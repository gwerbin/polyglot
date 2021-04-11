open Base
open Lwt.Infix
module Arg = Caml.Arg

open Httpaf
open Httpaf_lwt_unix


(* Mostly copied from https://github.com/inhabitedtype/httpaf/blob/10ce839/README.md *)
let request_handler reqd = 
  match Reqd.request reqd with
  | { Request.meth = `GET ; _ } ->
    let body = Printf.sprintf "\"Hello, %s!\"" "quackerman" in
    let headers =
      Headers.of_list
        [ "Content-Length", Int.to_string (String.length body);
          "Content-Type", "application/json; charset=utf-8" ]
    in
    Reqd.respond_with_string reqd (Response.create ~headers `OK) body
  | _ ->
    let headers = Headers.of_list [ "Connection", "close" ] in
    Reqd.respond_with_string reqd (Response.create ~headers `Method_not_allowed) ""
;;



(* Copied verbatim from https://github.com/inhabitedtype/httpaf/blob/10ce839/examples/lib/httpaf_examples.ml#L78-L88 *)
let error_handler ?request:_ error start_response =
  let response_body = start_response Headers.empty in
  begin match error with
    | `Exn exn ->
      Body.write_string response_body (Exn.to_string exn);
      Body.write_string response_body "\n";
    | #Status.standard as error ->
      Body.write_string response_body (Status.default_reason_phrase error)
  end;
  Body.close_writer response_body
;;


(* Yeah I copied this too ... *)
let r (_ : Unix.sockaddr) = request_handler
let e (_ : Unix.sockaddr) = error_handler
let main port =
  let listen_address = Unix.(ADDR_INET (inet_addr_loopback, port)) in
  Lwt.async (fun () ->
      Lwt_io.establish_server_with_client_socket
        listen_address
        (Server.create_connection_handler ~request_handler:r ~error_handler:e)
      >|= fun _server ->
      Stdio.printf "Listening on port %i\n" port);
  let forever, _ = Lwt.wait () in
  Lwt_main.run forever
;;


let () = let port = 8080 in main port ;;

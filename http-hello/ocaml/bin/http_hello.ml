open Base
open Httpaf
open Httpaf_lwt_unix
open Lazy
open Lwt.Infix
module Time = Core.Time


let make_utf8_headers media_type body = Headers.of_list
    [ "Content-Type", Printf.sprintf "%s; charset=utf-8" media_type;
      "Content-Length", Int.to_string (String.length body) ]
;;


let respond_json reqd data =
  let body = (Yojson.pretty_to_string data) in
  let headers = make_utf8_headers "application/json" body in
  let response = Response.create ~headers `OK in
  Reqd.respond_with_string reqd response body
;;


(* TODO: use Timere *)
let rfc3339_now =
  let tz = (force Timezone.local) in
  let tz_str = "asdfasdfadsf why is this so difficult wtf" in
  let now = Time.now () in
  let now_str = Time.to_sec_string now ~zone:tz in
  Printf.sprintf "%s %s" now_str tz_str
;;
(*   let t = Unix.localtime in *)
(*   let tz = force Timezone.local in *)
(*   Printf.sprintf *)
(*     "%04d-%02d-%02d %02d:%02d:%02d -%02d:02d" *)
(*     t.tm_year *)
(*     t.tm_month *)
(*     t.tm_day *)
(*     t.tm_hour *)
(*     t.tm_min *)
(*     t.tm_sec *)
(*     offhour *)
(*     offmin *)
(* ;; *)


let silly_data = 
  `Assoc [
    "time", `String (rfc3339_now);
    "datum", `List [
      `String "eAcute is \u{E9}, combinedEAcute is \u{65}\u{301}; precomposed is \u{D55C}, decomposed is \u{1112}\u{1161}\u{11AB}";
      `Int 10000000;
      `Null;
      `List [`Int 0; `Float 0.0];
    ]
  ]
;;


let request_handler reqd = 
  match Reqd.request reqd with

  | { Request.meth = `GET ; _ } ->
    respond_json reqd silly_data
  | _ ->
    let response = Response.create `Method_not_allowed in
    Reqd.respond_with_string reqd response ""
;;


(* Copied from https://github.com/inhabitedtype/httpaf/blob/10ce83/examples/lib/httpaf_examples.ml#L78-L88 *)
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


let main port = 
  let listen_address = Unix.(ADDR_INET (inet_addr_loopback, port)) in
  let r (_ : Unix.sockaddr) = request_handler in
  let e (_ : Unix.sockaddr) = error_handler in
  Lwt.async
    (fun () -> 
       Lwt_io.establish_server_with_client_socket
         listen_address
         (Server.create_connection_handler ~request_handler:r ~error_handler:e)
       >|= fun _server -> Stdio.printf "Listening on port %i\n" port
    );
  let forever, _ = Lwt.wait() in
  Lwt_main.run forever
;;


let () =
  let port = 8080 in main port
;;

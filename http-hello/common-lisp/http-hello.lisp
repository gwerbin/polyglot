(defpackage #:http-hello
  (:use #:cl))

(in-package #:http-hello)

(require "asdf")
(asdf:load-system "cl-interpol")
(asdf:load-system "cl-json")
(asdf:load-system "local-time")
(asdf:load-system "hunchentoot")

(cl-interpol:enable-interpol-syntax)

(defparameter *version* 1.0)

(hunchentoot:define-easy-handler (handle-root :uri "/") ()
  (sleep 0.25)
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (let* ((now (local-time:format-rfc3339-timestring nil (local-time:now)))
         (data (list (cons "time" now)
                     (cons "datum" (list #?"eAcute is \x{00E9}, combinedEAcute is \x{0065}\x{0301}; precomposed is \x{D55C}, decomposed is \x{1112}\x{1161}\x{11AB}"
                                         1
                                         nil
                                         #(0 0.0)))))
         (data-enc (json:encode-json-to-string data)))
    (format nil "~a" data-enc)))

(defparameter *acceptor* (make-instance 'hunchentoot:easy-acceptor :port 4242))
(hunchentoot:start *acceptor*)
;(hunchentoot:stop *acceptor*)


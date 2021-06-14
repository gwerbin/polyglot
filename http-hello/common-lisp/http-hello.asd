(asdf:defsystem "http-hello"
  :serial t
  :description "HTTP Hello"
  :author "Greg Werbin <outthere@me.gregwerbin.com>"
  :version "0.0.1"
  :license "MIT"
  :depends-on ("cl-interpol"
               "cl-json"
               "local-time"
               "hunchentoot")
  :components ((:file "http-hello"))
  :in-order-to ((test-op (test-op "foobar/tests"))))

;(asdf:defsystem "http-hello/tests"
;  :depends-on ("http-hello" "fiveam")
;  :components ((:file "http-hello-tests"))
;  :perform (test-op (o c) (symbol-call :fiveam '#:run! :http-hello)))


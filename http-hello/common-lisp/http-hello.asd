(asdf:defsystem "http-hello"
  :serial t
  :description "HTTP Hello"
  :author "Greg Werbin <outthere@me.gregwerbin.com>"
  :version "0.0.1"
  :license "MIT"
  :depends-on ("cl-json"
               "cl-who"
               "hunchentoot")
  :components ((:file "http-hello")))

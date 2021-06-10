(asdf:load-system "cl-json")
(asdf:load-system "hunchentoot")

(defclass datetime
  (timestamp :initarg :timestamp))

; (defclass datetime
;   (year
;     :initarg :year
;     :initform 0
;     :accessor year)
;   (month
;     :initarg :month
;     :initform 0
;     :accessor month)
;   (day
;     :initarg :day
;     :initform 0
;     :accessor day)
;   (hours
;     :initarg :hours
;     :initform 0
;     :accessor hours)
;   (minutes
;     :initarg :minutes
;     :initform 0
;     :accessor minutes)
;   (seconds
;     :initarg :seconds
;     :initform 0
;     :accessor seconds)
;   (dst
;     :initarg :dst
;     :initform nil
;     :accessor dst)
;   (tz
;     :initarg :tz
;     :initform "utc"
;     :accessor tz))

; (defun now (&key (tz "utc"))
;   (when (string-not-equal tz "utc")
;     (error "Only utc is supported."))
;   (multiple-value-bind (seconds minutes hours day month year day-of-week dst tz) (get-decoded-time)
;     (make-instance 'datetime :seconds seconds :minutes minutes :hours hours :day day :month month :year year :dst dst :tz tz)))

(defun get-decoded-time-tz (&optional (tz nil))
  (if tz
    (decode-universal-time (get-universal-time) tz)
    (get-decoded-time)))

(defun sign (x)
  (cond ((= x 0) 0)
        ((> x 0) 1)
        ((< x 0) -1)))

(defun make-utc-offset-string (tz &optional (dst-p nil))
  (multiple-value-bind (inv-tz-hours tz-hours-frac) (floor tz)
    (let* ((tz-hours (* -1 inv-tz-hours))
           (dst-offset (if dst-p 1 0))
           (tz-minutes (* tz-hours-frac 60))
           (tz-hours-dst (+ dst-offset tz-hours)))
      (format nil "~2,'0@d:~2,'0d" tz-hours-dst tz-minutes))))

(defun rfc3339-now (&optional (tz nil))
  (multiple-value-bind (seconds minutes hours day month year _ dst-p tz) (get-decoded-time-tz tz)
    (declare (ignore _))
    (let ((utc-offset-string (make-utc-offset-string tz dst-p)))
      (format nil
              "~4,'0d-~2,'0d-~2,'0d ~2,'0d:~2,'0d:~2,'0d ~a"
              year
              month
              day 
              hours 
              minutes 
              seconds 
              utc-offset-string))))

(hunchentoot:define-easy-handler (handle-hello :uri "/") ()
  (sleep 0.25)
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  ; {"time": "<datetime>", "datum": ["eAcute is é, combinedEAcute is é; precomposed is 한, decomposed is 한", 1, null, [0, 0.0]]}
  (let* ((now (rfc3339-now))
         (data (list (cons "time" now)
                     (cons "datum" (list "eAcute is é, combinedEAcute is é; precomposed is 한, decomposed is 한"
                                         1
                                         nil
                                         #(0 0.0)))))
         (data-enc (json:encode-json-to-string data)))
    (format nil "~a" data-enc)))

(defparameter *acceptor* (make-instance 'hunchentoot:easy-acceptor :port 4242))
(hunchentoot:start *acceptor*)
(hunchentoot:stop *)

; (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor
;                                   :port 4242))
; (hunchentoot:stop *)

(DEFSTRUCT student ID NAME group)
(SETF (GET 'db_student' ID_COUNTER) 5)
(SETQ db_student
  (CONS (MAKE-student :ID 1 :NAME 'NAME1 :group 4432)
    (CONS (MAKE-student :ID 2 :NAME 'NAME2 :group 4531)
      (CONS (MAKE-student :ID 3 :NAME 'NAME3 :group 2718)
        (CONS (MAKE-student :ID 4 :NAME 'NAME4 :group 4536)
          (CONS (MAKE-student :ID 5 :NAME 'NAME5 :group 4531) NIL))))))

(DEFUN ADD_student (); add studebt
  (SETQ new_record (MAKE-student))
  (FORMAT T "       Add student card       ~%")
  (FORMAT T "Input name: ~%")
  (SETF (student-NAME new_record) (read))
  (FORMAT T "Input group: ~%")
  (SETF (student-group new_record) (read))
  (SETF (student-ID new_record) (INCF (GET 'db_student' ID_COUNTER)))
  (SETQ db_student (APPEND db_student (CONS new_record NIL)))
  (FORMAT T "The card has been added.~%")
       (print_student new_record))

(DEFUN DELETE_student (RECORDS);; delete student
  (COND
    ((NULL RECORDS) NIL)
	(T
	  (SETQ db_student (REMOVE (CAR RECORDS) db_student))
	  (DELETE_student (CDR RECORDS)))))

(DEFUN EDIT_student (n)
  (FORMAT T "Input name: ")
  (SETF (student-name n) (READ))
  (FORMAT T "Input group: ")
  (SETF (student-group n) (READ)))

(defun process_delete_student() ;; process of student deletion
    (FORMAT T "Enter id of student to delete~%")
    (SETQ _id (read))
    (SETQ del_record (search_db db_student (LAMBDA (n) (IF (EQ (student-ID n) _id) T NIL))))
    (IF (NULL del_record)
    (FORMAT T "The record not found~%")
    (PROGN (DELETE_student del_record)
    (FORMAT T "The student has been deleted.~%"))))
    
(defun process_edit_student()
	  (FORMAT T "       Edit student card       ~%")
	  (FORMAT T "Input card ID: ")
	  (SETQ _id (READ))
	  (SETQ ed_record (SEARCH_db db_student (LAMBDA (n) (IF (EQ (student-ID n) _id) T NIL))))
	  (IF (NULL ed_record)
	    (FORMAT T "The card not found~%")
		(PROGN (EDIT_student (CAR ed_record))
		 (FORMAT T "The card has been edited.~%")))
        )

(DEFSTRUCT record ID id_student id_book)
(SETF (GET 'db_record' ID_COUNTER) 5)
(SETQ db_record
  (CONS (MAKE-record :ID 1 :id_student 5 :id_book "do androids dream of electric sheep?")
    (CONS (MAKE-record :ID 2 :id_student 4 :id_book "name of the rose")
      (CONS (MAKE-record :ID 3 :id_student 3 :id_book "otci i deti")
        (CONS (MAKE-record :ID 4 :id_student 2 :id_book "buratino")
           (CONS (MAKE-record :ID 5 :id_student 2 :id_book 1)
              (CONS (MAKE-record :ID 6 :id_student 1 :id_book "povest vremennih let") NIL)))))))


(DEFUN add_record (); add record
  (SETQ new_record (MAKE-record))
  (FORMAT T "       Add record       ~%")
  (FORMAT T "Input id of student: ~%")
  (SETF (record-id_student new_record) (read))
  (FORMAT T "Input id of book: ~%")
  (SETF (record-id_book new_record) (read))
  (SETF (record-ID new_record) (INCF (GET 'db_record' ID_COUNTER)))
  (SETQ db_record (APPEND db_record (CONS new_record NIL)))
  (FORMAT T "The record has been added.~%")
       (print_record new_record))

(DEFUN DELETE_record (RECORDS);; delete record
  (COND
    ((NULL RECORDS) NIL)
	(T
	  (SETQ db_record (REMOVE (CAR RECORDS) db_record))
	  (DELETE_record (CDR RECORDS)))))

(DEFUN EDIT_record (n)
  (FORMAT T "Input id of student: ")
  (SETF (record-id_student n) (READ))
  (FORMAT T "Input name of book: ")
  (SETF (record-id_book n) (READ)))



(defun process_delete_record() ;; process of student deletion
    (FORMAT T "Enter id of record to delete~%")
    (SETQ _id (read))
    (SETQ del_record (search_db db_record (LAMBDA (n) (IF (EQ (record-ID n) _id) T NIL))))
    (IF (NULL del_record)
    (FORMAT T "The record not found~%")
    (PROGN (DELETE_record del_record)
    (FORMAT T "The record has been deleted.~%"))))

(defun process_edit_record()
	  (FORMAT T "       Edit record       ~%")
	  (FORMAT T "Input record ID: ")
	  (SETQ _id (READ))
	  (SETQ ed_record (SEARCH_db db_record (LAMBDA (n) (IF (EQ (record-ID n) _id) T NIL))))
	  (IF (NULL ed_record)
	    (FORMAT T "The record not found~%")
		(PROGN (EDIT_record (CAR ed_record))
		 (FORMAT T "The record has been edited.~%")))
		 )

(DEFUN search_db (SEQ CRITERIA);; search in every db for criteria
  (COND
    ((NULL SEQ) NIL)
	(T
	  (IF (FUNCALL CRITERIA (CAR SEQ)) 
	    (CONS (CAR SEQ) (search_db (CDR SEQ) CRITERIA))
		(search_db (CDR SEQ) CRITERIA)))))


;;;  print students section
(DEFUN PRINT_student (n)
  (COND
    ((NULL n) NIL)
    (T 
	  (FORMAT T "       Student #~A       ~%" (student-id n))
      (FORMAT T "Name: ~A~%" (student-name n))
      (FORMAT T "Group: ~A~%" (student-group n)))))
(DEFUN PRINT_students (SEQ)
  (COND
    ((NULL SEQ) T)
	(T
	  (PRINT_student (CAR SEQ))
	  (TERPRI)
	  (PRINT_students  (CDR SEQ)))))
;; print records section
(DEFUN PRINT_record (n)
  (COND
    ((NULL n) NIL)
    (T 
	  (FORMAT T "       Record #~A       ~%" (record-id n))
      (FORMAT T "Student: ~A~%" (record-id_student n))
      (FORMAT T "Book: ~A~%" (record-id_book n)))))
  
(DEFUN PRINT_records (SEQ)
  (COND
    ((NULL SEQ) T)
	(T
	  (PRINT_record (CAR SEQ))
	  (TERPRI)
	  (PRINT_records  (CDR SEQ)))))


(DEFUN PRINT_MENU ()
  (FORMAT T "        Library        ~%")
  (FORMAT T "1 All students~%")
  (FORMAT T "2 All records~%")
  (FORMAT T "3 Add student card~%")
  (FORMAT T "4 Add record~%")
  (FORMAT T "5 Delete student~%")
  (FORMAT T "6 Delete record~%")
  (FORMAT T "7 Search~%")
  (FORMAT T "8 Edit student~%")
  (FORMAT T "9 Edit record~%")
  (FORMAT T "0 Exit~%")
  (READ))

(DEFUN PRINT_SEARCH_MENU ()
  (FORMAT T "       Search record       ~%")
  (FORMAT T "1. Find student by ID~%")
  (FORMAT T "2. Search students by group number~%")
  (FORMAT T "3. Search books of student~%")
  (FORMAT T "4. Search records by book~%")
  (READ))
  

(defun process_search()
    	  (SETQ choice (PRINT_SEARCH_MENU))
	  (COND
	    ((EQ choice 1)
		  (FORMAT T "Input student card id:~%")
		  (SETQ _id (READ))
		  (PRINT_students
		    (SEARCH_db 
			  db_student 
			  (LAMBDA (n) (IF (EQ (student-ID n) _id) T NIL)))))
		((EQ choice 2) 
		  (FORMAT T "Input group number:~%")
		  (SETQ _name (READ))
		  (PRINT_students 
		    (SEARCH_db 
			  db_student
			  (LAMBDA (n) (IF (EQ (student-group n) _name) T NIL)))))
		((EQ choice 3) 
		  (FORMAT T "Input student id:~%")
		  (SETQ _phone (READ))
		  (PRINT_records 
		    (SEARCH_db 
			  db_record 
			  (LAMBDA (n) (IF (EQUALP (record-id_student n) _phone) T NIL)))))
		((EQ choice 4)
		  (FORMAT T "Input book name(with double brackets):~%")
		  (SETQ _phone (READ))
		  (PRINT_records 
		    (SEARCH_db 
			  db_record 
			  (LAMBDA (n) (IF (EQUALP (record-id_book n) _phone) T NIL)))))
       )
    )




(DEFUN MAIN ()
  (SETQ choice (PRINT_MENU))
  (COND
    ((EQ choice 0) T)
	((EQ choice 1)
        (PRINT_students db_student)
	    (MAIN))
	((EQ choice 2)
        (PRINT_records db_record)
	  (MAIN))
	((EQ choice 3)
     (add_student)
	  (MAIN))
	((EQ choice 4)
     (add_record)
	  (MAIN))
   	((EQ choice 5)
     (process_delete_student)
	  (MAIN))
    ((EQ choice 6)
     (process_delete_record)
	  (MAIN))
    ((EQ choice 7)
     (process_search)
	  (MAIN))
	((EQ choice 8)
     (process_edit_student)
	  (MAIN))
	((EQ choice 9)
     (process_edit_record)
	  (MAIN))
	(T
	  (MAIN))))
(main)

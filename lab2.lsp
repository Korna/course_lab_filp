(defun fsymb (line)
(if (null line)
      nil
(cons (car (car line)) (fsymb (cdr line)))))

(defun esymb (line)
(if (null line)
      nil
(cons (cdr (car line)) (esymb (cdr line)))))

(defun transpose (matrix)
(cond 
((null matrix) nil)
((null (car matrix)) nil)
(t (cons (fsymb matrix) (transpose (esymb matrix))))

))

(setq MALIST '(; список предпочтений мужчин
(a . '(A E C I J D F B H G))

(b . '(C H A D E F B J I G))

(c . '(H E A D B F I G C J))

(d . '(I F D G H E J B C A))

(e . '(J D B C F E A I H G))

(f . '(B A D G E I C J H F))

(g . '(G E I B C A D H J F))

(h . '(A E H F I C J B G D))

(i . '(H C D G B A F I J E))

(j . '(A F J G E B D C I H))
))
(print "Man preferences map")
(print MALIST)
(setq WALIST '(
(A . '(b f j g i a d e c h))

(B . '(b a c f g d i e j h))

(C . '(f b e g h c i a d j))

(D . '(f j c a i h g d b e))

(E . '(j h f d a g c e i b))

(F . '(b a e i j d f g c h))

(G . '(j g h f b a c e d i))

(H . '(g j b a i d h e c f))

(I . '(i c h g f b a e j d))

(J . '(e h g a b j c i f ))
))
(print "Woman preferences map")
(print WALIST)

(defvar ENG '()); здесь вссе созданные пары
(defvar FREE '(a b c d e f h i j));;свободные мужчины
(print "Free man set")
(print FREE)

(defun engage(female male);создание пары женщина-мужчина
    (FORMAT T "Engage woman ~A with ~A~%" female male)
    (setq ENG (acons female male ENG)); (setf ENG(my-append (list female male) ENG))
       ;(print ENG)
    )
(defun change_mind(female male);замена пары
	(FORMAT T "Woman ~A changed mind to ~A~%" female male)
    (setq ENG (delete (assoc female ENG) ENG))
    (setq ENG (acons female male ENG))
    
    ;(setq ENG (subst (cons female male)(nth 0 ENG) ENG))
    )


(setq gman nil);инициализация временной переменной для возврата из функции
(setq gwan '());переменная с полным списком предпочтений

(defun cut_m();взять и удалить первого свободного мужчину
    (setq gman (car FREE))
    (setq FREE (cdr FREE))
     (return-from cut_m gman)
    )

(defun cut_w(M);первая женщина из списка предпочтений мужчины
    (setq gwan (car (cdr(cdr (assoc M MALIST)))));assign pure list to var
    (FORMAT T "Man ~A prefer ~A~%" M (car gwan))
    (return-from cut_w (car gwan))
    )
(setq pref nil)
(setq temp nil)
(defun rem_w(M W);удалить женщину из списка предпочтений
	(FORMAT T "Delete woman ~A from list of ~A~%" W M)
    (setq pref (delete W (car (cdr(cdr(assoc M MALIST))))))

    
    (setq pref(cons pref '()))
    (setq pref(cons 'QUOTE pref))

    (setq MALIST(delete (assoc M MALIST) MALIST))

    

     (setq MALIST (acons M pref MALIST))
    
    
    )

(defun isFree(W);;return T если свободна nil иначе
 (if(assoc W ENG) (return-from isFree nil)
    (return-from isFree T))
)
(defun getPosition(woman guy);взять позицию в списке приоритетов
   ; (print (position guy (car(cdr(cdr(assoc woman WALIST))))))
    (return-from getPosition (position guy (car(cdr(cdr(assoc woman WALIST)))))
        )
    )
(defun get_old_man(woman);;взять старого мужика женщины из списка помолвок
    ;(print (assoc woman WALIST))
    (return-from get_old_man (cdr (assoc woman ENG)))
    )
(defun prefer_new(woman new old);;предпочитает ли нового. T если да и nil иначе
    (if (< (getPosition woman new) (getPosition woman old)) (return-from prefer_new T);(print 'NEW)
        (return-from prefer_new nil);(print 'OLD)
    )
)
;(preferNew 'a 'c 'b)


(defun process_change(W)
   
    (pushnew (get_old_man W) FREE);сделать старого мужика свободным
    (rem_w (get_old_man W) W) ;удалить у старого мужчины из списка предпочтений жену
    (change_mind W gman) ; помолвить женщину с другим (WIP)
    
    )

(defun process(W)
    (if(isFree W) (engage W gman); если свободна
       (if(prefer_new W gman (get_old_man W)) (process_change W)
          (rem_w gman W)
          )
    )
)

(defun print_end()
    (print "Enf of recursion.")
    (print "Pairs are:")

    (print ENG)
    (read)
    )


(defun find_stable()
    ;(print FREE)
    (cond ;((equal FREE '(a b c d e f h i j))
           ;(print 'START)(find_stable))
       (FREE 	(FORMAT T "List of free man:~A~%" FREE)

             (process (cut_w (cut_m))); удаляем свободного мужчину и берем первую женщину из списка предпочтений и передаем в функцию
             (find_stable)
             )
    ((not FREE) (print_end))
)
    )

(print 'START)
(find_stable)

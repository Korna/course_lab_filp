(SETQ lst '(a (b c) (d e) (k)))
 (CADR (CADDR '(a (b c) (d e) (k)) ))
(CAAR (CDDDR '(a (b c) (d e) (k))))
(CONS (CAADDR (CDR lst))
(CONS (CAR lst)
(CONS (CAADDR lst) nil)
))
(CONS (CAADR lst)
(CONS (CAR lst)
(CONS (CAAR (CDDDR lst)) nil )
))
(SETQ lst '(a (b c) (d e) (k)))

(CONS (CADADR lst)
(CONS (CAADDR lst)
(CONS (CAAR (CDDDR lst)) nil)
))

(CONS (CADR lst)
(CONS (CAR lst) nil) )

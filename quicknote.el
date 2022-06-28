;;; -*- lexical-binding: t; -*-

(require 'posframe)
(require 'projectile)

(global-set-key [f8] 'quicknote)
(global-set-key [f7] 'quicknotel)
(global-set-key [f3] 'shell-tog)
(global-set-key (kbd "s-<f7>") 'openagen)

(defun openagen()
  (interactive)
   (find-file "/Users/pranshu/Documents/agenda.org")
  )
;; make a agenda and a temprary

;;save befere exit
;(delete-file "/Users/pranshu/.emacs.d/scratch.org")


;buffer-file-name for file name
; buffer-name
(setq path "nil")
(setq bname nil)

(global-set-key (kbd "M-§") 'setstuff)

(defun setstuff()
  (interactive)
    (message "File set: %S" (buffer-name))
    (setq bname (buffer-name))
    (setq path (buffer-file-name))
)
(defun quicknote()
 (interactive)
  (if (string= path "nil")
      (setstuff)
 (progn


;  (add-hook 'post-command-hook (lambda()				 )  nil t)
    (global-unset-key (kbd "<escape>"))
(global-set-key (kbd "<escape>") (lambda()
				   (interactive)
				   (save-buffer)
				     (posframe-delete-all)
				      (global-unset-key (kbd "<escape>"))
				      (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
				      (global-set-key [f8] 'quicknote)
				      (global-set-key [f7] 'quicknotel)
				      ))
(global-unset-key [f8])
(global-set-key [f8] (lambda()
		       (interactive)
		       (execute-kbd-macro (kbd "<escape>"))))

(when (not(get-buffer bname))
  (find-file-noselect path)
  )


  (posframe-show

     bname
   :poshandler 'posframe-poshandler-frame-center

   :border-color "#00bcff"
   :width (round (* (frame-width) 0.70))
   :height (round (* (frame-height) 0.85))
   :border-width 2
   :override-parameters '((left-fringe . 20)
			  (right-fringe . 20)
			  (cursor-type . box)
			  )
   :accept-focus t
   :font
   )

   (with-current-buffer bname
     (setq-local cursor-type t)
      (setq-local cursor-in-non-selected-windows 'box))
   )))
(defun quicknotel()
  (interactive)

;  (add-hook 'post-command-hook (lambda()				 )  nil t)
    (global-unset-key (kbd "<escape>"))
(global-set-key (kbd "<escape>") (lambda()
				   (interactive)
				   (save-buffer)
				     (posframe-delete-all)
				      (global-unset-key (kbd "<escape>"))
				      (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
				      (global-set-key [f7] 'quicknotel)
				      				      (global-set-key [f8] 'quicknote)

				      ))
(global-unset-key [f7])
(global-set-key [f7] (lambda()
		       (interactive)
		       (execute-kbd-macro (kbd "<escape>"))))

(when (not(get-buffer "scratch.org"))
  (find-file-noselect "/Users/pranshu/Documents/agenda.org")
  )


  (posframe-show

     "agenda.org"
   :poshandler 'posframe-poshandler-frame-center
   :border-color "#00bcff"
   :width (round (* (frame-width) 0.80))
   :height (round (* (frame-height) 0.90))
   :border-width 2
   :override-parameters '((left-fringe . 20)
			  (right-fringe . 20)
			  (cursor-type . box)
			  )
   :accept-focus t

   )

   (with-current-buffer "agenda.org"
     (setq-local cursor-type t)
     (setq-local cursor-in-non-selected-windows 'box))

   )




(defun shell-toggle--get-directory ()

  (if  (projectile-project-root)
	(projectile-project-root)

      (file-name-directory buffer-file-name)

      )
  )


(defun shell-tog()
  (interactive)


  (if(get-buffer "*shell*")
      (if (get-buffer-window "*shell*")
	 (delete-window (get-buffer-window "*shell*"))	        ;;
	 (progn			        ;;
	   (split-window-below)	        ;;
	   (other-window 1)		        ;;
	  (switch-to-buffer "*shell*")        ;;
	   )


	  )
   (progn      (split-window-below)	  (other-window 1)(let ((default-directory (shell-toggle--get-directory)))(shell) ) )
     )
;  (seq-contains "shell" (window-list ))

  )

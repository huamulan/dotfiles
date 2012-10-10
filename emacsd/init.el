;;turn on server mode
(server-start)

(add-to-list 'load-path "~/.emacs.d/vendor")

;; set emacs bash path to match shell bash path
(setenv "PATH" (shell-command-to-string "bash -i -c 'echo -n $PATH'"))

;; some packages use mapcan which was removed in emacs 24
(require 'cl)

;; recursively add subdirs in vendor to load path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/vendor")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; autoload config files in the config folder
(defconst emacs-config-dir "~/.emacs.d/configs/" "")
(setq load-path (cons "~/.emacs.d" load-path))
(defun load-cfg-files (filelist)
  (dolist (file filelist)
    (load (expand-file-name
           (concat emacs-config-dir file)))
    (message "Loaded config file: %s" file)
    ))

;; load nxhtml mode
(load "~/.emacs.d/vendor/nxhtml/autostart.el")

(load-cfg-files '(
                  "main"
                  "mac" ;; mac specific key bindings and ui changes
                  "modeline"
                  "project" ;; project definitions
                  ;; "vim" ;; vim keybindings yo
                  "grep"
                  "ack"
                  "autocomplete"
                  ;; languages
                  "python"
                  "javascript"
                  "ruby"
                  "yaml"
                  "html"
                  "css"
                  ))

(setq custom-file "~/.emacs.d/configs/custom.el")

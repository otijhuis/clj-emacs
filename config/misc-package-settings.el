;; Rich minority (clean up modeline)
(require 'rich-minority)
(setq rm-blacklist '(" hl-s"
                     " company"
                     " wr"
                     " Guide"
                     " Anzu"
                     " ing"
                     " WLR"
                     " Anzu"
                     " ElDoc"
                     " Paxedit"
                     " Paredit"
                     " $"
                     " =>"
                     " SliNav"
                     " WSC"
                     " VHl"
                     " yas"
                     " drag"))
(rich-minority-mode 1)

;; Multiple Cursors
(require 'multiple-cursors)
(setq mc/unsupported-minor-modes '(company-mode auto-complete-mode flyspell-mode jedi-mode))

;; Volatile Highlights
(require 'volatile-highlights)

(volatile-highlights-mode t)

;; Indent Guide
(require 'indent-guide)

(indent-guide-global-mode)

(setq indent-guide-threshold 0)
(setq indent-guide-recursive t)
(setq indent-guide-delay 0.1)

;; Key chords
(require 'key-chord)

(setq key-chord-two-keys-delay 0.2)

(key-chord-mode +1)

;; If no region is selected then work on current line
(require 'whole-line-or-region)

(whole-line-or-region-mode 1)

;; Undo tree
(setq undo-tree-mode-lighter "")
(require 'undo-tree)
(global-undo-tree-mode)

;; Keep region when undoing in region
(defadvice undo-tree-undo (around keep-region activate)
  (if (use-region-p)
      (let ((m (set-marker (make-marker) (mark)))
            (p (set-marker (make-marker) (point))))
        ad-do-it
        (goto-char p)
        (set-mark m)
        (set-marker p nil)
        (set-marker m nil))
    ad-do-it))

;; Highlight symbol
(setq highlight-symbol-idle-delay 0.5)

;; Wrap region
(wrap-region-global-mode)

;; Drag stuff
(setq drag-stuff-modifier 'hyper)
(require 'drag-stuff)
(drag-stuff-global-mode t)

;; Thing at point
(require 'thingatpt)
(require 'thingatpt+)

;; iMenu list
(require 'imenu-list)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-auto-resize t)
(setq imenu-list-position 'left)

;; Beacon
(beacon-mode 1)
(setq beacon-color "orange")
(setq beacon-size 50)
(setq beacon-blink-when-point-moves-vertically 3)
(setq beacon-blink-when-point-moves-horizontally 20)
(setq beacon-blink-duration 0.2)
(setq beacon-blink-delay 0.2)
(setq beacon-blink-when-focused t)
(setq beacon-dont-blink-commands '())
(setq beacon-lighter " 💡")

(add-hook 'beacon-dont-blink-predicates
          (lambda ()
            (if (string-prefix-p "avy-" (symbol-name (or this-command last-command)))
                t
              nil)))

;; State
(require 'state)
(state-global-mode 1)

(state-define-state
    scratch
  :key "s"
  :switch "*scratch*")

(state-define-state
  message
  :key "m"
  :switch "*Messages*")

;; Ivy / Swiper / Counsel
(require 'swiper)
(require 'flx)

(setq ivy-format-function 'ivy-format-function-arrow)

;;(ivy-mode 1)

(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))

;;(setq ivy-initial-inputs-alist nil)

(setq ivy-extra-directories nil)

(setq ivy-use-virtual-buffers t)
(setq ivy-height 10)
;;(setq ivy-count-format "(%d/%d) ")
(setq ivy-count-format "")

(setq ivy-wrap nil)

(require 'counsel)

(setq counsel-find-file-at-point t)

(setq counsel-find-file-ignore-regexp
      (concat
       ;; file names beginning with # or .
       "\\(?:\\`[#.]\\)"
       ;; file names ending with # or ~
       "\\|\\(?:\\`.+?[#~]\\'\\)"))

;; Redefine `counsel-ag-base-command' with my required options, especially
;; the `--follow' option to allow search through symbolic links.
(setq counsel-ag-base-command (concat "ag "
                                      "--noheading "
                                      "--nogroup "
                                      "--nocolor "
                                      "--skip-vcs-ignores "
                                      "--smart-case "
                                      "--follow " ; follow symlinks
                                      "%S"))

(provide 'misc-package-settings)


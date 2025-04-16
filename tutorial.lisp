(let ((quicklisp-init "quicklisp/setup.lisp"))
	(when (probe-file quicklisp-init)
	      (load quicklisp-init)))

(mapc #'ql:quickload
      '(:cl-fad :cl-who :hunchentoot :parenscript :cl-utilities :cl-ppcre))

(defpackage "PS-TUTORIAL"
  (:use "COMMON-LISP" "HUNCHENTOOT" "CL-WHO" "PARENSCRIPT" "CL-FAD" "CL-UTILITIES" "CL-PPCRE"))

(in-package "PS-TUTORIAL")

(start (make-instance 'easy-acceptor :port 5555))

(setq cl-who:*attribute-quote-char* #\")

(defun my-debug (val)
  (format t "DEBUG: ~A~%" val)
  val)

(defun auto-dark-mode-transform-class (c)
  (let* ((colors '("-100" "-200" "-300" "-400"  "white" "-500" "black" "-600" "-700" "-800" "-900"))
	 (reversed (reverse colors))
	 (newclass c))
    (or
     (loop for from in colors for to in reversed do
       (setq newclass (regex-replace-all from c to))
       (when (string/= newclass c) (return (concatenate 'string c " dark:" newclass))))
     c)))

(defun auto-dark-mode-transform-classes (classes)
  (format nil "~{~A~^ ~}" 
	  (mapcar #'auto-dark-mode-transform-class
		  (split-sequence:split-sequence #\Space classes))))

(defun auto-dark-mode-helper (tree)
  (if (eq (type-of tree) 'cons)
      (labels
	  ((out (resttree)
	     (if resttree
		 (if (eq (car resttree) :class)
		     `(:class ,(auto-dark-mode-transform-classes (car (cdr resttree))) ,@(out (cdr (cdr resttree))))
		     (cons
		      (if (eq (type-of (car resttree)) 'cons)
			  (let
			      ((x (car resttree)))
			    (auto-dark-mode-helper x))
			  (car resttree))
		      (out (cdr resttree)))))))
	(out tree))
      tree))

(defmacro auto-dark-mode (on tree) (if on (auto-dark-mode-helper tree) tree))

(defvar inter-font-css "/* inter-latin-wght-normal */
@font-face {
  font-family: 'Inter Variable';
  font-style: normal;
  font-display: block;
  font-weight: 100 900;
  src: url(https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/latin-opsz-normal.woff2) format('woff2-variations');
  unicode-range: U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD;
}

/* inter-cyrillic-ext-wght-normal */
@font-face {
  font-family: 'Inter Variable';
  font-style: normal;
  font-display: block;
  font-weight: 100 900;
  src: url(https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/cyrillic-ext-opsz-normal.woff2) format('woff2-variations');
  unicode-range: U+0460-052F,U+1C80-1C8A,U+20B4,U+2DE0-2DFF,U+A640-A69F,U+FE2E-FE2F;
}

/* inter-greek-wght-normal */
@font-face {
  font-family: 'Inter Variable';
  font-style: normal;
  font-display: block;
  font-weight: 100 900;
  src: url(https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/greek-opsz-normal.woff2) format('woff2-variations');
  unicode-range: U+0370-0377,U+037A-037F,U+0384-038A,U+038C,U+038E-03A1,U+03A3-03FF;
}

/* inter-greek-ext-wght-normal */
@font-face {
  font-family: 'Inter Variable';
  font-style: normal;
  font-display: block;
  font-weight: 100 900;
  src: url(https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/greek-ext-opsz-normal.woff2) format('woff2-variations');
  unicode-range: U+1F00-1FFF;
}

/* inter-cyrillic-wght-normal */
@font-face {
  font-family: 'Inter Variable';
  font-style: normal;
  font-display: block;
  font-weight: 100 900;
  src: url(https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/cyrillic-opsz-normal.woff2) format('woff2-variations');
  unicode-range: U+0301,U+0400-045F,U+0490-0491,U+04B0-04B1,U+2116;
}

/* inter-latin-ext-wght-normal */
@font-face {
  font-family: 'Inter Variable';
  font-style: normal;
  font-display: block;
  font-weight: 100 900;
  src: url(https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/latin-ext-opsz-normal.woff2) format('woff2-variations');
  unicode-range: U+0100-02BA,U+02BD-02C5,U+02C7-02CC,U+02CE-02D7,U+02DD-02FF,U+0304,U+0308,U+0329,U+1D00-1DBF,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20C0,U+2113,U+2C60-2C7F,U+A720-A7FF;
}

/* inter-vietnamese-wght-normal */
@font-face {
  font-family: 'Inter Variable';
  font-style: normal;
  font-display: block;
  font-weight: 100 900;
  src: url(https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/vietnamese-opsz-normal.woff2) format('woff2-variations');
  unicode-range: U+0102-0103,U+0110-0111,U+0128-0129,U+0168-0169,U+01A0-01A1,U+01AF-01B0,U+0300-0301,U+0303-0304,U+0308-0309,U+0323,U+0329,U+1EA0-1EF9,U+20AB;
}")

(defun random-emoji ()
  (let ((emojis '("😀" "😎" "🎉" "💻" "🔥" "🚀" "🌈" "🍕" "🐱" "🧠")))
    (nth (random (length emojis)) emojis)))

(define-easy-handler (example1 :uri "/") ()
  (auto-dark-mode t
		  (with-html-output-to-string (s)
		    (htm (:html
			  (:head
			   (:title "Tailwind + cl-who Example")
			   (:meta :name "viewport" :content "width=device-width, initial-scale=1.0")
			   (:script :src "https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js")
			   (:link :rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/fomantic-ui@2.9.4/dist/semantic.min.css")
			   (:script :src "https://cdn.jsdelivr.net/npm/fomantic-ui@2.9.4/dist/semantic.min.js")
			   (:style :type "text/css" inter-font-css)
			   (:script :src "https://cdn.tailwindcss.com")
			   (:script :src "https://cdn.jsdelivr.net/npm/htmx.org@2.0.4/dist/htmx.min.js")
			   (:script :type "text/javascript"
				    (str (ps
					   (setq tailwind.config (create dark-mode "class" important t))
					   (defun handle-color-scheme-change (e)
					     (if (getprop e 'matches)
						 (document.document-element.class-list.add "dark")
						 (document.document-element.class-list.remove "dark")))
					   (handle-color-scheme-change (window.match-media "(prefers-color-scheme: dark)"))
					   ((@ (window.match-media "(prefers-color-scheme: dark)") add-listener) handle-color-scheme-change))))
			   (:style :type "text/css" "
html, body {
  font-size: 16px;
}
.ui,.ui *,body,h1,h2,h3,h4,h5 {
  font-family: 'Inter Variable';
}
.ff {
  font-family: 'Inter Variable'!important;
}
i.outline {
    outline-style: none !important; /* To override `outline` in Tailwind` */
}
"))
			  (:body :class "bg-zinc-100 md:p-8 transition-colors duration-150"
				 (:noscript "No javascript? That's a shame. The page is going to look like shit. Still, the content is server-side generated and will be readable.")
				 (:div :class "mx-auto bg-white md:rounded-xl shadow-md overflow-hidden max-w-2xl p-8"
				       (:div :class "mb-4 flex justify-between items-center"
					     (:h1 :class "text-xl tracking-widest font-light text-zinc-900" (esc (concatenate 'string (random-emoji) " wembsite")))
					     (:button :class "ui icon button bg-zinc-200 text-black dark:hidden"
						      :onclick (ps (document.document-element.class-list.add "dark")) (:i :class "sun icon"))
					     (:button :class "ui icon button bg-zinc-200 text-black hidden dark:block"
						      :onclick (ps (document.document-element.class-list.remove "dark")) (:i :class "moon icon")))
				       (:hr :class "mb-4")
				       (:h1 :class "text-2xl font-bold text-zinc-900" "Hello, Tailwind + cl-who!")
				       (:p :class "mt-2 text-zinc-600"
					   "This is a paragraph styled with Tailwind classes from within cl-who.")
				       (:button :class "mt-4 ff ui button bg-zinc-200 text-black" :hx-post "/htmx" :hx-swap "outerHTML" "Click me")
				       (dolist
					   (par '("a" "b" "c"))
					 (htm (:p :class "mt-4 text-black" (esc par)))))))))))

(define-easy-handler (example2 :uri "/htmx") ()
  (auto-dark-mode t
		  (with-html-output-to-string (s)
		    (htm
		     (:div :class "shadow-none bg-zinc-100 text-zinc-800 py-[.78571429em] ui message transition"
			   (:p :class "mb-0 border-0" :onclick (ps (chain ($ this) (transition "fade"))) "Well done")
			   (:i :class "close icon text-zinc-800" :onclick  (ps (chain ($ this)
										      (closest ".message")
										      (transition "fade")))))))))

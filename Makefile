appdir: docker
	[ -d app ] && rm -r app || true
	mkdir app
	docker run gauche_heroku_app | (cd app && tar xvf -)

docker: src
	docker build -t gauche_heroku_app .

src: Gauche
	cd Gauche && git pull origin master

Gauche:
	git clone https://github.com/shirok/Gauche.git

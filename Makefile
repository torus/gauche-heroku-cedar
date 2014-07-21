appdir: docker
	[ -d app ] && rm -fr app || true
	mkdir app
	docker run gauche_heroku_app | (cd app && tar xvf -)

docker: src
	docker build -t gauche_heroku_app .

src: Gauche Gauche-makiki Gauche-redis
	cd Gauche && git pull origin master
	cd Gauche-makiki && git pull origin master
	cd Gauche-redis && git pull origin master

Gauche:
	git clone https://github.com/shirok/Gauche.git

Gauche-makiki:
	git clone https://github.com/shirok/Gauche-makiki.git

Gauche-redis:
	git clone https://github.com/bizenn/Gauche-redis.git

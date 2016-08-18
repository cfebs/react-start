JS_SOURCE_FILES := $(shell find ./src/js -type f)
SCSS_SOURCE_FILES := $(shell find ./src/scss -type f)
PORT := 8181
ADDR :='0.0.0.0'

.PHONY: css js watch-js watch-css serve npm

all: npm css js

css: npm build/app.css

js: npm build/app.js

npm: .cache/npm

.cache/npm: package.json
	mkdir -p ./.cache
	npm install && touch ./.cache/npm

build/app.js: $(JS_SOURCE_FILES) index.html
	mkdir -p build
	$(shell npm bin)/browserify src/js/index.es6 -t [ babelify --presets [ es2015 react ] ] -o build/app.js

build/app.css: $(SCSS_SOURCE_FILES)
	mkdir -p build
	$(shell npm bin)/node-sass ./src/scss/main.scss ./build/app.css

watch-js:
	mkdir -p build
	$(shell npm bin)/watchify src/js/index.es6 -t [ babelify --presets [ es2015 react ] ] -o build/app.js -v

watch-css:
	mkdir -p build
	$(shell npm bin)/node-sass -w ./src/scss/main.scss ./build/app.css

serve:
	python3 -m http.server --bind $(ADDR) $(PORT)

clean:
	rm -rf ./build/*

PRESENTATION=presentation

all: $(PRESENTATION).html

$(PRESENTATION).html: $(PRESENTATION).adoc
	bundle exec asciidoctor-revealjs $(PRESENTATION).adoc
	ruby -run -e httpd . -p 5000 -b 127.0.0.1 &
	firefox 127.0.0.1:5000/$(PRESENTATION).html

config:
	sudo gem install asciidoctor-revealjs
	sudo gem install bundler
	echo "source 'https://rubygems.org'" > Gemfile
	echo "gem 'asciidoctor-revealjs'" >> Gemfile
	bundle config --local path .bundle/gems
	bundle
	git submodule update --init --checkout

clean:
	rm -rf $(PRESENTATION).html
	killall ruby
PIP := pip
PUBLISH_SRC := site/
PUBLISH_TARGET := www.zuar.com:static/w3/api/mitto/__stage__

pyenv:
	[ ! -f requirements.txt ] || $(PIP) install -r requirements.txt
.PHONY: pyenv

css:
	[ -d docs/css ] || mkdir docs/css
	pygmentize -S default -f html -a .codehilite > docs/css/pygments.css
.PHONY: css	

# run all jobs and create log files
logs: drop_schemas drop_stores load_logs store_logs upsert_logs
.PHONY: logs

build:
	mkdocs build
.PHONY: build

clean:
	rm -rf site
.PHONY: clean

serve:
	mkdocs serve -vs
.PHONY: serve

publish:
	rsync -arv $(PUBLISH_SRC) $(PUBLISH_TARGET)
.PHONE: publish

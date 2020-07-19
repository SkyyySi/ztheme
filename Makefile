DESTDIR := /
PREFIX  := $(DESTDIR)usr
INSTALL := install

install:
	$(INSTALL) -m 0755 -D files/bin/ztheme $(PREFIX)/bin/ztheme
	mkdir -p $(PREFIX)/share/
	cp -r files/share/ztheme/ $(PREFIX)/share/ztheme/


uninstall:
	rm -rf $(PREFIX)/share/ztheme/ \
	      $(PREFIX)/bin/ztheme

.PHONY: install uninstall


include config.mk

NAME = zubak
PROG = bin/zubak
MANPAGE = zubak.1
HELPERS = bin/zubak-gather bin/zubak-compress bin/zubak-next-backup-id bin/zubak-split bin/zubak-begin bin/zubak-end bin/zubak-archive

default: zubak.1

install: $(PROG) $(HELPERS) install-man
	install -d $(PREFIX)/bin
	install -d $(PREFIX)/libexec/zubak
	install $(PROG) $(PREFIX)/bin/
	install $(HELPERS) $(PREFIX)/libexec/zubak/

$(MANPAGE): zubak.pod
	pod2man $< $@

install-man: $(MANPAGE)
	install -d $(PREFIX)/man/man1
	install $(MANPAGE) $(PREFIX)/man/man1/

dist: $(NAME)-$(VERSION).tar.gz

$(NAME)-$(VERSION).tar.gz: $(NAME)-$(VERSION)
	tar -czf $@ $<
	rm -Rf $<

manifest: MANIFEST

MANIFEST: MANIFEST.SKIP
	find * | egrep -v -f $< > $@

$(NAME)-$(VERSION): MANIFEST
	[ -d $@ ] || mkdir $@
	cpio -p -m $@ < $<

clean:
	rm -Rf $(NAME)-$(VERSION)* MANIFEST

.PHONY: default install install-man dist clean manifest

include config.mk

PROG = bin/zubak
MANPAGE = zubak.1
HELPERS = bin/zubak-gather bin/zubak-compress bin/zubak-next-backup-id bin/zubak-split bin/zubak-archive

default: zubak.1

install: $(PROG) $(HELPERS) install-man
	install -d $(PREFIX)/bin
	install -d $(PREFIX)/libexec/zubak
	install $(PROG) $(PREFIX)/bin/
	install $(HELPERS) $(PREFIX)/libexec/zubak/

$(MANPAGE): zubak.pod
	pod2man $< $@

install-man: $(MANPAGE)
	install -d $(PREFIX)/man/
	install $(MANPAGE) $(PREFIX)/man/man1/

.PHONY: default install install-man

include config.mk

PROG = bin/zubak
MANPAGE = zubak.1
HELPERS = bin/zubak-backup bin/zubak-compress bin/zubak-gather bin/zubak-next-backup-id bin/zubak-split

default:
	@/bin/true

install: $(PROG) $(HELPERS) install-man
	install -d $(PREFIX)/bin
	install -d $(PREFIX)/libexec/zubak
	install $(PROG) $(PREFIX)/bin/
	install $(HELPERS) $(PREFIX)/libexec/zubak/

$(MANPAGE): zubak.pod
	pod2man $< $@

install-man: $(MANPAGE)
	install -d $(PREFIX)/man/
	install $(MANPAGE) $(PREFIX)/man/

.PHONY: default install install-man

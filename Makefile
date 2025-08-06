PREFIX=/usr
MANDIR=$(PREFIX)/share/man
BINDIR=$(PREFIX)/bin

all:
	@echo "Run 'make install' for installation."
	@echo "Run 'make uninstall' for uninstallation."

install:
	install -CDm755 create_ap $(DESTDIR)$(BINDIR)/create_ap
	install -CDm755 linux-router/lnxrouter $(DESTDIR)$(BINDIR)/lnxrouter

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/create_ap
	rm -f $(DESTDIR)$(BINDIR)/lnxrouter

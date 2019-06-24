#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

LITENOTED=${BITCOIND:-$BINDIR/litenoted}
LITENOTECLI=${BITCOINCLI:-$BINDIR/litenote-cli}
LITENOTETX=${BITCOINTX:-$BINDIR/litenote-tx}
LITENOTEQT=${BITCOINQT:-$BINDIR/qt/litenote-qt}

[ ! -x $LITENOTED ] && echo "$LITENOTED not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
XSNVER=($($LITENOTECLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoind if --version-string is not set,
# but has different outcomes for bitcoin-qt and bitcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$LITENOTED --version | sed -n '1!p' >> footer.h2m

for cmd in $LITENOTED $LITENOTECLI $LITENOTETX $LITENOTEQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${XSNVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${XSNVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m

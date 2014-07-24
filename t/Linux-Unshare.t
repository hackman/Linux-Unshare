use strict;
use warnings FATAL => 'all';

use Test::More tests => 4;
BEGIN { use_ok('Linux::Unshare', qw(unshare CLONE_NEWNS CLONE_FS unshare_ns)) };

SKIP: {
	skip "Should be root to test mount --bind", 1 if $<;
	my $pid = fork();
	if ($pid) {
		waitpid($pid, 0);
	} else {
		# Legacy unshare_ns should return 0 on success
		unshare_ns() and die $!;
		system("mount --bind /dev/null $0") and die;
		exit;
	}
	my $res = `umount $0 2>&1`;
	isnt($res, '');
};

is(unshare(CLONE_NEWNS), $< ? undef : 1);
is(unshare(CLONE_FS), 1);

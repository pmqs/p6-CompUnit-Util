use Test;
use CompUnit::Util :find-loaded,:load,:all-loaded, :at-unit;
plan 10;

ok my $native-call = load('NativeCall'),'load';
ok $native-call === load('NativeCall'), 'load again returns same thing';

ok find-loaded('Test') ~~ CompUnit:D, 'found Test';
ok find-loaded('CompUnit::Util') ~~ CompUnit:D, 'found CompUnit::Util';
nok find-loaded('Foo'),'find-loaded on non-existent module returns false';
ok find-loaded('Foo') ~~ Failure:D,'returns Failure';

ok all-loaded()».short-name.pick(*) ~~ set('CompUnit::Util','NativeCall','Test'),
"all-loaded finds the correct units";

my $cu = load('CompUnit::Util');
my $pod = at-unit('CompUnit::Util','$=pod')[0];
ok  $pod ~~ Pod::Block:D, 'at-unit finds $=pod';
ok at-unit($cu,'$=pod')[0] === $pod,'at-units works with CompUnit';
ok at-unit($cu.handle,'$=pod')[0] === $pod,'at-units works with CompUnit::Handle';

use strict;
use ExtUtils::MakeMaker 6.17;

my $EUMM = 'ExtUtils::MakeMaker'->VERSION;

my $meta = {
  "abstract"           => "Moops Object-Oriented Programming Sugar",
  "author"             => ["Toby Inkster (TOBYINK) <tobyink\@cpan.org>"],
  "dynamic_config"     => 0,
  "generated_by"       => "Dist::Inkt::Profile::TOBYINK version 0.006, CPAN::Meta::Converter version 2.120921",
  "keywords"           => [],
  "license"            => ["perl_5"],
  "meta-spec"          => {
                            url => "http://search.cpan.org/perldoc?CPAN::Meta::Spec",
                            version => 2,
                          },
  "name"               => "Moops",
  "no_index"           => { directory => ["eg", "examples", "inc", "t", "xt"] },
  "prereqs"            => {
                            configure => { requires => { "ExtUtils::MakeMaker" => 6.17 } },
                            runtime => {
                              requires => {
                                            "Devel::Pragma"        => 0.54,
                                            "Exporter::TypeTiny"   => 0.022,
                                            "Function::Parameters" => 1.0201,
                                            "Import::Into"         => "1.000000",
                                            "Keyword::Simple"      => 0.01,
                                            "Module::Runtime"      => 0.013,
                                            "Moo"                  => "1.003000",
                                            "MooseX::MungeHas"     => 0.002,
                                            "MooX::late"           => 0.014,
                                            "namespace::sweep"     => 0.006,
                                            "perl"                 => 5.014,
                                            "Scalar::Util"         => 1.24,
                                            "true"                 => 0.18,
                                            "Try::Tiny"            => 0.12,
                                            "Type::Utils"          => 0.022,
                                          },
                              suggests => {
                                            "Moose" => "2.0600",
                                            "MooseX::XSAccessor" => 0,
                                            "MooX::HandlesVia" => 0,
                                            "Mouse" => "1.00",
                                          },
                            },
                            test => {
                              recommends => { Moose => "2.0600", Mouse => "1.00" },
                              requires   => { "Test::Fatal" => 0, "Test::More" => 0.96, "Test::Requires" => 0 },
                              suggests   => { "MooseX::Types::Common::Numeric" => 0 },
                            },
                          },
  "provides"           => {
                            "Class::Tiny::Antlers"              => { file => "lib/Class/Tiny/Antlers.pm", version => 0.011 },
                            "Moops"                             => { file => "lib/Moops.pm", version => 0.011 },
                            "Moops::DefineKeyword"              => { file => "lib/Moops/DefineKeyword.pm", version => 0.011 },
                            "Moops::ImportSet"                  => { file => "lib/Moops/ImportSet.pm", version => 0.011 },
                            "Moops::Keyword"                    => { file => "lib/Moops/Keyword.pm", version => 0.011 },
                            "Moops::Keyword::Class"             => { file => "lib/Moops/Keyword/Class.pm", version => 0.011 },
                            "Moops::Keyword::Role"              => { file => "lib/Moops/Keyword/Role.pm", version => 0.011 },
                            "Moops::MethodModifiers"            => { file => "lib/Moops/MethodModifiers.pm", version => 0.011 },
                            "Moops::Parser"                     => { file => "lib/Moops/Parser.pm", version => 0.011 },
                            "Moops::TraitFor::Keyword::dirty"   => { file => "lib/Moops/TraitFor/Keyword/dirty.pm", version => 0.011 },
                            "Moops::TraitFor::Keyword::mutable" => { file => "lib/Moops/TraitFor/Keyword/mutable.pm", version => 0.011 },
                            "Moops::TraitFor::Keyword::ro"      => { file => "lib/Moops/TraitFor/Keyword/ro.pm", version => 0.011 },
                            "Moops::TraitFor::Keyword::rw"      => { file => "lib/Moops/TraitFor/Keyword/rw.pm", version => 0.011 },
                            "Moops::TraitFor::Keyword::rwp"     => { file => "lib/Moops/TraitFor/Keyword/rwp.pm", version => 0.011 },
                          },
  "release_status"     => "stable",
  "resources"          => {
                            bugtracker   => { web => "http://rt.cpan.org/Dist/Display.html?Queue=Moops" },
                            homepage     => "https://metacpan.org/release/Moops",
                            license      => ["http://dev.perl.org/licenses/"],
                            repository   => { type => "git", web => "https://github.com/tobyink/p5-moops" },
                            X_identifier => "http://purl.org/NET/cpan-uri/dist/Moops/project",
                          },
  "version"            => 0.011,
  "x_provides_scripts" => {},
};

my %dynamic_config;

my %WriteMakefileArgs = (
	ABSTRACT           => $meta->{abstract},
	AUTHOR             => ($EUMM >= 6.5702 ? $meta->{author} : $meta->{author}[0]),
	DISTNAME           => $meta->{name},
	VERSION            => $meta->{version},
	EXE_FILES          => [ map $_->{file}, values %{ $meta->{x_provides_scripts} || {} } ],
	NAME               => do { my $n = $meta->{name}; $n =~ s/-/::/g; $n },
	%dynamic_config,
);

$WriteMakefileArgs{LICENSE} => $meta->{license}[0] if $EUMM >= 6.3001;

sub deps
{
	my %r;
	for my $stage (@_)
	{
		for my $dep (keys %{$meta->{prereqs}{$stage}{requires}})
		{
			my $ver = $meta->{prereqs}{$stage}{requires}{$dep};
			$r{$dep} = $ver if !exists($r{$dep}) || $ver >= $r{$dep};
		}
	}
	\%r;
}

my ($build_requires, $configure_requires, $runtime_requires, $test_requires);
if ($EUMM >= 6.6303)
{
	$WriteMakefileArgs{BUILD_REQUIRES}     ||= deps('build');
	$WriteMakefileArgs{CONFIGURE_REQUIRES} ||= deps('configure');
	$WriteMakefileArgs{TEST_REQUIRES}      ||= deps('test');
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('runtime');
}
elsif ($EUMM >= 6.5503)
{
	$WriteMakefileArgs{BUILD_REQUIRES}     ||= deps('build', 'test');
	$WriteMakefileArgs{CONFIGURE_REQUIRES} ||= deps('configure');
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('runtime');	
}
elsif ($EUMM >= 6.52)
{
	$WriteMakefileArgs{CONFIGURE_REQUIRES} ||= deps('configure');
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('runtime', 'build', 'test');	
}
else
{
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('configure', 'build', 'test', 'runtime');	
}

{
	my $minperl = delete $WriteMakefileArgs{PREREQ_PM}{perl};
	exists($WriteMakefileArgs{$_}) && delete($WriteMakefileArgs{$_}{perl})
		for qw(BUILD_REQUIRES TEST_REQUIRES CONFIGURE_REQUIRES);
	if ($minperl and $EUMM >= 6.48)
	{
		$WriteMakefileArgs{MIN_PERL_VERSION} ||= $minperl;
	}
	elsif ($minperl)
	{
		die "Need Perl >= $minperl" unless $] >= $minperl;
	}
}

sub FixMakefile
{
	return unless -d 'inc';
	my $file = shift;
	
	local *MAKEFILE;
	open MAKEFILE, "< $file" or die "FixMakefile: Couldn't open $file: $!; bailing out";
	my $makefile = do { local $/; <MAKEFILE> };
	close MAKEFILE or die $!;
	
	$makefile =~ s/\b(test_harness\(\$\(TEST_VERBOSE\), )/$1'inc', /;
	$makefile =~ s/( -I\$\(INST_ARCHLIB\))/ -Iinc$1/g;
	$makefile =~ s/( "-I\$\(INST_LIB\)")/ "-Iinc"$1/g;
	$makefile =~ s/^(FULLPERL = .*)/$1 "-Iinc"/m;
	$makefile =~ s/^(PERL = .*)/$1 "-Iinc"/m;
	
	open  MAKEFILE, "> $file" or die "FixMakefile: Couldn't open $file: $!; bailing out";
	print MAKEFILE $makefile or die $!;
	close MAKEFILE or die $!;
}

my $mm = WriteMakefile(%WriteMakefileArgs);
FixMakefile($mm->{FIRST_MAKEFILE} || 'Makefile');
exit(0);


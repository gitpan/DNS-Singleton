use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME		=> 'DNS::Singleton',
    VERSION_FROM	=> 'lib/DNS/Singleton.pm',
    PREREQ_PM => {
		'Pod::Coverage' => 0.11,
		'Module::Info' => 0.12,
		'Test::More' => 0.41,
		'Memoize' => 0.66,
		'Storable' => 1.014,
		'Class::Singleton' => 1.03,
		'Tie::DNS' => undef,
	    },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/DNS/Singleton.pm', # retrieve abstract from module
      AUTHOR     => 'Iain Truskett <spoon@cpan.org>') : ()),
);



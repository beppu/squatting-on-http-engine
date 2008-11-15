use ExtUtils::MakeMaker;

WriteMakefile (
  NAME          => 'Squatting::On::HTTP::Engine',
  AUTHOR        => 'John BEPPU <beppu@cpan.org>',
  LICENSE       => 'mit',
  VERSION_FROM  => 'lib/Squatting/On/HTTP/Engine.pm',
  ABSTRACT_FROM => 'lib/Squatting/On/HTTP/Engine.pm',
  EXE_FILES     => [ 'bin/squatting' ],
  PREREQ_PM     => {
    'Squatting' => 0.52
  },
  depend => { distmeta => 'metamunge' }
);

sub MY::libscan {
  my $self = shift;
  $_       = shift;
  # $self appears to be a blessed hashref that contains
  # all the attributes/value pairs passed to WriteMakeFile()
  # plus some other MakeMaker-related info.
  return 0 if /\.sw.$/ || /~$/;
  return $_;
}

sub MY::postamble {q{
metamunge :
	$(NOECHO) $(ECHO) 'no_index:'        >> $(DISTVNAME)/META.yml
	$(NOECHO) $(ECHO) '    directory:'   >> $(DISTVNAME)/META.yml
	$(NOECHO) $(ECHO) '        - eg'     >> $(DISTVNAME)/META.yml
	$(NOECHO) $(ECHO) '        - t'      >> $(DISTVNAME)/META.yml

nd :
	$(MKPATH) doc
	$(MKPATH) /tmp/squatting-doc
	nd -r -i lib -o HTML doc -p /tmp/sqautting-doc
}}
package DNS::Singleton;

=head1 NAME

DNS::Singleton - gives a singleton DNS object

=head1 SYNOPSIS

    use DNS::Singleton;
    my $dns = DNS::Singleton->instance;

    my $host = $dns->host('150.203.115.7');

=head1 DESCRIPTION

The DNS::Singleton module provides a unique cached DNS lookup object for
all its instances within an application.

=cut

use 5.006;
use strict;
use warnings;
use Memoize;
use Tie::DNS;
use Storable;
use Class::Singleton;

our @ISA = qw/Class::Singleton/;
our ( $VERSION ) = '$Revision: 1.1.1.1 $ ' =~ /\$Revision:\s+([^\s]+)/;

my $cache_file = '/var/dns-cache';
tie my %dns, 'Tie::DNS';
memoize '_cache';
my $cache = {};
$cache = retrieve $cache_file if -f $cache_file;

# ========================================================================
#                                                                  Methods

=head1 METHODS

=over 4

=item my $dns = DNS::Singleton->instance()

Creates a new DNS singleton object.

=item my $host = $dns->host()

Returns the hostname for the given IP or vice versa.

=cut

sub host
{
    my ($self, $ip) = (@_);

    return _cache($ip);
}

=back

=cut

# ========================================================================
#                                                                  Private

=begin private

=head1 PRIVATE METHODS

=over 4

=item DNS::Singleton->_new_instance()

Required due to this being a subclass of L<Class::Singleton>. Creates
the internal singleton representation.

=cut

sub _new_instance
{
    my $class = shift;
    my $self  = bless { }, $class;
    return $self;
}

=item DNS::Singleton->_cache($ip)

Returns the cached value of the given C<$ip> or looks it up and returns
it while caching the result.

=cut

sub _cache
{
    my $ip = shift;
    unless (exists $cache->{$ip})
    {
	$cache->{$ip} = $dns{$ip}
    }
    return $cache->{$ip};
}

=item DNS::Singleton::DESTROY

Stores the internal cache to disc.

=cut

sub DESTROY
{
    store $cache, $cache_file;
}

=back

=end private

=cut

1;

#
# ========================================================================
#                                                Rest Of The Documentation

=head1 FILES

    /var/dns-cache

=head1 AUTHOR

Iain Truskett <spoon@cpan.org> L<http://eh.org/~koschei/>

Please report any bugs, or post any suggestions, to either the mailing
list at <cpan@dellah.anu.edu.au> (email
<cpan-subscribe@dellah.anu.edu.au> to subscribe) or directly to the
author at <spoon@cpan.org>

=head1 PLANS

Tied interface.

=head1 COPYRIGHT

Copyright (c) 2002 Iain Truskett. All rights reserved. This program is
free software; you can redistribute it and/or modify it under the same
terms as Perl itself.

    $Id: Singleton.pm,v 1.1.1.1 2002/03/06 06:40:43 koschei Exp $

=head1 ACKNOWLEDGEMENTS

None really. Just happened to need the facilities of this module.

=head1 SEE ALSO

L<Tie::DNS>, L<Class::Singleton>, L<Memoize>, L<Storable>


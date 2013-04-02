package HateBUserData::Tag;

use strict;
use warnings;
use base qw(MT::Plugin);
use MT::Template::Context;
use MT::Entry;


sub _hdlr_hateb_user_data {
    my ($ctx, $args) = @_;
    my $permalink;
    my $e = $ctx->stash('entry')
         or return $ctx->_no_entry_error();

    my $at = $ctx->{current_archive_type} || $ctx->{archive_type};
    my $archiver;
    $archiver = MT->publisher->archiver($at) if $at;

    if ( $at and $archiver and not $archiver->entry_based() ) {
        $permalink = $e->archive_url($at);
        $permalink .= '#entry-' . sprintf( "%06d", $e->id )
            unless $at eq 'Individual';
    }
    else {
        $permalink = $e->permalink;
        $permalink = MT::Util::strip_index( $permalink, $ctx->stash('blog') )
            unless $args->{with_index};
    }

    my $plugin = MT->component("HateBUserData");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $HatenaID = $plugin->get_config_value('HatenaID',$scope);
    my $rdf = <<"RDF";
<!-- 
<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:foaf="http://xmlns.com/foaf/0.1/">
<rdf:Description rdf:about="$permalink">
   <foaf:maker rdf:parseType="Resource">
     <foaf:holdsAccount>
       <foaf:OnlineAccount foaf:accountName="$HatenaID">
         <foaf:accountServiceHomepage rdf:resource="http://www.hatena.ne.jp/" />
       </foaf:OnlineAccount>
     </foaf:holdsAccount>
   </foaf:maker>
</rdf:Description>
</rdf:RDF>
 -->
RDF
    return $rdf;
}

1;
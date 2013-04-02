<?php 
function smarty_function_mthatebuserdata($args, &$ctx) {
    $blog = $ctx->stash('blog');
    $id = $blog->blog_id;
    $e = $ctx->stash('entry');
    $at = $ctx->stash('current_archive_type');

    if ($at) {
        $at = ArchiverFactory::get_archiver($at);
    }
    if ($at && !( $at instanceof IndividualArchiver )) {
        $permalink = $ctx->tag('ArchiveLink');
        $permalink .= '#entry-' . sprintf("%06d", $e->entry_id);
    } else {
        $permalink = $ctx->tag($e->entry_class.'Permalink', array('archive_type' => 'Individual'));
    }

    $blog_config[$id] = $ctx->mt->db()->fetch_plugin_data("HateBUserData", "configuration:blog:$id");
    $hatenaID = $blog_config[$id][HatenaID];
    if($hatenaID===null) {
        $hatenaID='HatenaID';
    }

$rdf = <<< RDF
<!-- 
<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:foaf="http://xmlns.com/foaf/0.1/">
<rdf:Description rdf:about="$permalink">
   <foaf:maker rdf:parseType="Resource">
     <foaf:holdsAccount>
       <foaf:OnlineAccount foaf:accountName="$hatenaID">
         <foaf:accountServiceHomepage rdf:resource="http://www.hatena.ne.jp/" />
       </foaf:OnlineAccount>
     </foaf:holdsAccount>
   </foaf:maker>
</rdf:Description>
</rdf:RDF>
 -->
RDF;

    return ($rdf);
}

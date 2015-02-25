### temporalia_solrify.pl
temporalia_solrify.pl is a Perl script used by an organiser to strip all tags from the collection and save it to a document format that can be used for Solr. Even if you don't use Solr as a backend system, the script might be useful for those who want to remove the tags. 

Here is a quick instruction. Assuming that you have uncompressed the collection into a folder "FOLDER", then all have to do is 

```perl temporalia_solrify.pl FOLDER/input.xml```

This will create a new file called "input_solr.xml"under the same folder as the original input file. We would suggest totry thescript with a couple ofinput files first. If they aresuccessful, youcan runit on all files. 
### temporalia_solrify.pl -> removes all tags in the body
temporalia_solrify.pl is a Perl script used by an organiser to strip all tags from the collection and save it to a document format that can be used for Solr. Even if you don't use Solr as a backend system, the script might be useful for those who want to remove the tags. 

Here is a quick instruction. Assuming that you have uncompressed the collection into a folder "FOLDER", then all have to do is 

```perl temporalia_solrify.pl FOLDER/input.xml```

This will create a new file called "input_solr.xml"under the same folder as the original input file. We would suggest totry thescript with a couple ofinput files first. If they aresuccessful, youcan runit on all files. 

***

### CheckSyntax.class -> correct some markup inconsistency
CheckSyntax.class is a Java class to turn the original document collection files into sanitised XML format. The program uses JSoup library as follows. 

```java -Xmx5G -cp .:jsoup-1.7.3.jar CheckSyntax INPUT_FILE > OUTPUT_FILE```

Note that the output tags will be -lowercased-, the doc ids between quotes and symbols should be properly xml-escaped (" to " and so on). 

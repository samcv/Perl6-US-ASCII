use US-ASCII::ABNF::Common;

package US-ASCII-C:ver<0.1.0> {
    # unicode basic latin is US-ASCII
    constant charset = set chr(0) .. chr(127);
}

role US-ASCII:ver<0.1.2>:auth<R Schmidt (ronaldxs@software-path.com)>
    does US-ASCII::ABNF::Common
    is Grammar
{
    token alpha     { <[A..Za..z]> }
    token upper     { <[A..Z]> }
    token lower     { <[a..z]> }
    token digit     { <[0..9]> }
    token xdigit    { <[0..9A..Fa..f]> }
    token hexdig    { <[0..9A..F]> }
    token alnum     { <[0..9A..Za..z]> }
    # see RT #130527 for why we might need _punct and _space
    token _punct    { <[\-!"#%&'()*,./:;?@[\\\]_{}]> }
    token punct     { <+_punct> }
    token graph     { <+_punct +[0..9A..Za..z]> }
    token blank     { <[\t\ ]> }
    # \n is $?NL - rakudo cheating to get around \x[85], OK for now
    token _space    { $?NL || <[\t\c[LINE TABULATION]\c[FF]\r\ ]> }
    token space     { <+_space> }
    token print     { <+_punct +_space +[0..9A..Za..z]> }
    token cntrl     { <[\x[0]..\x[f]]+[\x[7f]]> }
    token vchar     { <[\x[21]..\x[7E]]> }

#   crlf not working yet
#    token crlf      { <CR><LF> }
    # todo ww, wb others?
    # token NL ??

    method charset { US-ASCII-C::charset }
}

# if uou are not using inheritance then US-ASCII::alpha as above is
# easier to read then US-ASCII::ALPHA.  You might want to inherit the
# rules and not overwrite the builtins as provided below.
role US-ASCII-UC:ver<0.1.2>:auth<R Schmidt (ronaldxs@software-path.com)> 
    does US-ASCII::ABNF::Common
{
    token ALPHA     { <.US-ASCII::alpha> }
    token UPPER     { <.US-ASCII::upper> }
    token LOWER     { <.US-ASCII::lower> }
    token DIGIT     { <.US-ASCII::digit> }
    token XDIGIT    { <.US-ASCII::xdigit> }
    token HEXDIG    { <.US-ASCII::hexdig> }
    token ALNUM     { <.US-ASCII::alnum> }
    token PUNCT     { <.US-ASCII::punct> }
    token GRAPH     { <.US-ASCII::graph> }
    token BLANK     { <.US-ASCII::blank> }
    token SPACE     { <.US-ASCII::space> }
    token PRINT     { <.US-ASCII::print> }
    token CNTRL     { <.US-ASCII::cntrl> }
    token VCHAR     { <.US-ASCII::vchar> }
#    token CRLF      { <.US-ASCII::crlf>  }

    # believied only useful for ABNF grammar
    token HTAB      { <[\t]> }
    token DQUOTE    { <["]> }

    method charset { US-ASCII-C::charset }
}

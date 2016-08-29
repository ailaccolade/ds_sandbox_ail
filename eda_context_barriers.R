require(tm)
require(quanteda)
require(RColorBrewer)


nts<- read.csv("~/Desktop/phonecall_description.tsv", header = F, sep = "\t")
ntc<- Corpus(DataframeSource(nts))

tag_removal<- cleanFun <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}


custom_stops = c('div', 
                 'class', 
                 'strong',
                 'dashedrules',
                 'span',
                 'font-size',
                 'style',
                 'small',
                 'ext',
                 'can', 
                 'know', 
                 'let', 
                 'look', 
                 'nbsp', 
                 'want', 
                 'date', 
                 'question',
                 'createdtype', 
                 'action',
                 'call',
                 'client',
                 'vm',
                 'note',
                 'voicemail',
                 'number',
                 'dos',
                 'claim',
                 'will',
                 'note',
                 'phone',
                 'notes',
                 'summary',
                 'topic',
                 'p',
                 'fu')

ntc<- tm_map(ntc, content_transformer(tag_removal))
ntc<- tm_map(ntc, content_transformer(tolower))
ntc<- tm_map(ntc, removeWords, custom_stops)
ntc<- tm_map(ntc, removeWords, stopwords(kind="english"))
ntc<- tm_map(ntc, content_transformer(removeNumbers))
ntc<- tm_map(ntc, content_transformer(removePunctuation))
#ntc<- tm_map(ntc, stemDocument)
ntc<- tm_map(ntc, removeWords, stopwords(kind="english"))
#ntc<- tm_map(ntc, content_transformer(tokenize))

make_dtm<- function(corpus, sparsity){
  d<- pretty_text(corpus)
  dtm<- DocumentTermMatrix(d)
  dtms<- removeSparseTerms(dtm, sparsity)
  return(dtms)
}

CR_dict<- c("caregiver", "care giver", "working long", "husband works", "wife works", "little time")
SS_dict<- c("lives alone", "no spouse", "no family", "relies on")
Access_dict<- c("rural", "cant drive")
EcSit_dict<- c("cant pay", "too high cost", "debt", "credit", "collector", "hardship")
Skills_dict<- c("language barrier", "confused", "complicated", "didnt understand")
Emtnst_dict<- c("upset", "angry", "emotional", "crying", "cry", "cried", "sad", "depressed", "emotional state")
Att_dict<- c("attitude") 
Spirit_dict<- c("religion", "prayer", "god", "spirit", "faith")

qdc<- quanteda::corpus(ntc)


kw_context_by_list<- function(list){
  con <- data.frame()
  for (word in list) {
    context = kwic(qdc, word)
    con = rbind(con, context)
  }
  return(con)}

lst_proc_qandd<- function(list, q_corp, output){
  obs<- kw_context_by_list(list)
  words<- quanteda::corpus(obs, q_corp)
  wdfm<- dfm(words)
  return(wdfm)
}

cr_list<- kw_context_by_list(CR_dict)
write.csv(cr_list, file="~/Desktop/cr_list.csv")

ss_list<- kw_context_by_list(SS_dict)
write.csv(ss_list, file="~/Desktop/ss_list.csv")

access_list<- kw_context_by_list(Access_dict)
write.csv(access_list, file="~/Desktop/access_list.csv")

att_list<- kw_context_by_list(Att_dict)
write.csv(att_list, file="~/Desktop/att_list.csv")

Ecsit_list<- kw_context_by_list(EcSit_dict)
write.csv(Ecsit_list, file="~/Desktop/Ecsit_list.csv")

Emsit_list<- kw_context_by_list(Emtnst_dict)
write.csv(Emsit_list, file="~/Desktop/Emsit_list.csv")

Skills_list<- kw_context_by_list(Skills_dict)
write.csv(Skills_list, file="~/Desktop/Skills_list.csv")

Spirit_list<- kw_context_by_list(Spirit_dict)
write.csv(Spirit_list, file="~/Desktop/Spirit_list.csv")

set.seed(42)

CR<- lst_proc_qandd(CR_dict, qdc)
plot(CR, max.words = 100, colors = brewer.pal(10, "Paired"), scale = c(8, .5))

Access<- lst_proc_qandd(Access_dict, qdc)
plot(Access, max.words = 100, colors = brewer.pal(10, "Paired"), scale = c(8, .5))

Att<- lst_proc_qandd(Att_dict, qdc)
plot(Att, max.words = 100, colors = brewer.pal(10, "Paired"), scale = c(8, .5))

EcSit<- lst_proc_qandd(EcSit_dict, qdc)
plot(EcSit, max.words = 100, colors = brewer.pal(10, "Paired"), scale = c(8, .5))

Emst<- lst_proc_qandd(Emtnst_dict, qdc)
plot(Emst, max.words = 60, colors = brewer.pal(10, "Paired"), scale = c(8, .5))

Skills<- lst_proc_qandd(Skills_dict, qdc)
plot(Skills, max.words = 50, colors = brewer.pal(10, "Paired"), scale = c(8, .5))

Spirit<- lst_proc_qandd(Spirit_dict, qdc)
plot(Spirit, max.words = 100, colors = brewer.pal(10, "Paired"), scale = c(8, .5))

SS_l<- lst_proc_qandd(SS_dict, qdc)
plot(SS_l, max.words = 100, colors = brewer.pal(12, "Paired"), scale = c(8, .5))

# synthetic_data_implementation_LDA = function(data, vocab, K, seed){
#   library(lda)
#   set.seed(seed)
#   res = lda.collapsed.gibbs.sampler(data,5,vocab,25,0.1,0.1,
#                                     compute.log.likelihood = T)
#   A_hat = t(result$document_sums) / colSums(result$document_sums)
#   
#   return(A_hat)
# }

synthetic_data_implementation_LDA = function(D,K,seed=NULL){
  library(topicmodels)
  if (is.null(seed)){
    LDA_obj <- LDA(t(D), K, method = 'VEM')
  } else{
    LDA_obj <- LDA(t(D), K, method = 'VEM', control=list(seed=seed))
  }
  set.seed(seed)
  D_sim <- exp(LDA_obj@beta)
  D_sim = t(D_sim)
  print(paste(nrow(D_sim),ncol(D_sim)))
  return(D_sim)
}




# require("ggplot2")
# require("reshape2")
# require("lda")
# data(cora.documents)
# data(cora.vocab)
# 
# theme_set(theme_bw())
# set.seed(8675309)
# 
# K <- 10 ## Num clusters
# result <- lda.collapsed.gibbs.sampler(cora.documents,
#                                       K,  ## Num clusters
#                                       cora.vocab,
#                                       25,  ## Num iterations
#                                       0.1,
#                                       0.1,
#                                       compute.log.likelihood=TRUE) 
# 
# ## Get the top words in the cluster
# top.words <- top.topic.words(result$topics, 5, by.score=TRUE)
# 
# ## Number of documents to display
# N <- 10
# 
# topic.proportions <- t(result$document_sums) / colSums(result$document_sums)
# topic.proportions <-
#   topic.proportions[sample(1:dim(topic.proportions)[1], N),]
# topic.proportions[is.na(topic.proportions)] <-  1 / K
# 
# colnames(topic.proportions) <- apply(top.words, 2, paste, collapse=" ")
# 
# topic.proportions.df <- melt(cbind(data.frame(topic.proportions),
#                                    document=factor(1:N)),
#                              variable.name="topic",
#                              id.vars = "document")  
# 
# ggplot(topic.proportions.df, aes(x=topic, y=value, fill=document), ylab="proportion") +
#   geom_bar(stat="identity") +
#   theme(axis.text.x = element_text(angle=90, hjust=1)) +
#   coord_flip() +
#   facet_wrap(~ document, ncol=5)
# 

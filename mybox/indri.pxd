from libcpp.string cimport string
cdef extern from "indri/QueryEnvironment.hpp" namespace "indri::api":
    cdef cppclass QueryEnvironment:
        QueryEnvironment() #except +
        int termCount()
        int documentCount()

        void setMemory(int)
        void setBaseline(string)
        void setSingleBackgroundModel(bool)
        #void setScoringRules( const std::vector<std::string>& rules );
        #void setStopwords( const std::vector<std::string>& stopwords );

        void addServer(string)
        void addIndex(string)
        #void addIndex( class IndexEnvironment& environment );
        void close()
        void removeServer(string)
        void removeIndex(string)
        QueryResults runQuery(QueryRequest)

      /// \brief Run an Indri query language query. @see ScoredExtentResult
      /// @param query the query to run
      /// @param resultsRequested maximum number of results to return
      /// @return the vector of ScoredExtentResults for the query
      std::vector<indri::api::ScoredExtentResult> runQuery( const std::string& query, int resultsRequested, const std::string &queryType = "indri" );

      /// \brief Run an Indri query language query. @see ScoredExtentResult
      /// @param query the query to run
      /// @param documentSet the working set of document ids to evaluate
      /// @param resultsRequested maximum number of results to return
      /// @return the vector of ScoredExtentResults for the query
      std::vector<indri::api::ScoredExtentResult> runQuery( const std::string& query, const std::vector<lemur::api::DOCID_T>& documentSet, int resultsRequested, const std::string &queryType = "indri" );

      /// \brief Run an Indri query language query. @see QueryAnnotation
      /// @param query the query to run
      /// @param resultsRequested maximum number of results to return
      /// @return pointer to QueryAnnotations for the query
      QueryAnnotation* runAnnotatedQuery( const std::string& query, int resultsRequested, const std::string &queryType = "indri" );

      /// \brief Run an Indri query language query. @see QueryAnnotation
      /// @param query the query to run
      /// @param documentSet the working set of document ids to evaluate
      /// @param resultsRequested maximum number of results to return
      /// @return pointer to QueryAnnotations for the query
      QueryAnnotation* runAnnotatedQuery( const std::string& query, const std::vector<lemur::api::DOCID_T>& documentSet, int resultsRequested, const std::string &queryType = "indri" );


      /// \brief Fetch the parsed documents for a given list of document ids.
      /// Caller is responsible for deleting the returned elements.
      /// @param documentIDs the list of ids
      /// @return the vector of ParsedDocument pointers.
      std::vector<indri::api::ParsedDocument*> documents( const std::vector<lemur::api::DOCID_T>& documentIDs );
      /// \brief Fetch the parsed documents for a given list of ScoredExtentResults
      /// Caller is responsible for deleting the returned elements.
      /// @param results the list of ScoredExtentResults
      /// @return the vector of ParsedDocument pointers.
      std::vector<indri::api::ParsedDocument*> documents( const std::vector<indri::api::ScoredExtentResult>& results );
      /// \brief Fetch the named metadata attribute for a list of document ids
      /// @param documentIDs the list of ids
      /// @param attributeName the name of the metadata attribute
      /// @return the vector of string values for that attribute
      std::vector<std::string> documentMetadata( const std::vector<lemur::api::DOCID_T>& documentIDs, const std::string& attributeName );
      /// \brief Fetch the named metadata attribute for a list of ScoredExtentResults
      /// @param documentIDs the list of ScoredExtentResults
      /// @param attributeName the name of the metadata attribute
      /// @return the vector of string values for that attribute
      std::vector<std::string> documentMetadata( const std::vector<indri::api::ScoredExtentResult>& documentIDs, const std::string& attributeName );

      /// \brief Fetch the XPath names of extents for a list of ScoredExtentResults
      /// @param results the list of ScoredExtentResults
      /// @return the vector of string XPath names for the extents
      std::vector<std::string> pathNames( const std::vector<indri::api::ScoredExtentResult>& results );


      /// \brief Fetch all documents with a metadata key that matches attributeName, with a value matching one of the attributeValues.
      /// @param attributeName the name of the metadata attribute (e.g. 'url' or 'docno')
      /// @param attributeValues values that the metadata attribute should match
      /// @return a vector of ParsedDocuments that match the given metadata criteria
      std::vector<indri::api::ParsedDocument*> documentsFromMetadata( const std::string& attributeName, const std::vector<std::string>& attributeValues );

      /// \brief Return a list of document IDs where the document has a metadata key that matches attributeName, with a value matching one of the attributeValues.
      /// @param attributeName the name of the metadata attribute (e.g. 'url' or 'docno')
      /// @param attributeValue values that the metadata attribute should match
      /// @return a vector of ParsedDocuments that match the given metadata criteria
      std::vector<lemur::api::DOCID_T> documentIDsFromMetadata( const std::string& attributeName, const std::vector<std::string>& attributeValue );
      /// \brief Return the stem of the term
      /// @param term the term to stem
      /// @return the stem of the term
      std::string stemTerm(const std::string &term);
      /// \brief Return total number of unique terms.
      /// @return total number of unique terms in the aggregated collection
      INT64 termCountUnique();
      /// \brief Return total number of terms.
      /// @return total number of terms in the aggregated collection
      INT64 termCount();
      /// \brief Return total number of term occurrences.
      /// @param term the term to count
      /// @return total frequency of this term in the aggregated collection
      INT64 termCount( const std::string& term );
      /// \brief Return total number of stem occurrences.
      /// @param term the stem to count
      /// @return total frequency of this stem in the aggregated collection
      INT64 stemCount( const std::string& term );
      /// \brief Return total number of term occurrences within a field.
      /// @param term the term to count
      /// @param field the name of the field
      /// @return total frequency of this term within this field in the
      /// aggregated collection
      INT64 termFieldCount( const std::string& term, const std::string& field );
      /// \brief Return total number of stem occurrences within a field.
      /// @param term the stem to count
      /// @param field the name of the field
      /// @return total frequency of this stem within this field in the
      /// aggregated collection
      INT64 stemFieldCount( const std::string& term, const std::string& field );
      /// \brief Return the total number of times this expression appears in the collection.
      /// @param expression The expression to evaluate, probably an ordered or unordered window expression
      double expressionCount( const std::string& expression,
                              const std::string &queryType = "indri" );
      /// \brief Return the total number of documents this expression appears in the collection.
      /// @param expression The expression to evaluate, probably an ordered or unordered window expression
      double documentExpressionCount( const std::string& expression,
                              const std::string &queryType = "indri" );
      /// \brief Return all the occurrences of this expression in the collection.
      /// Note that the returned vector may be quite large for large collections, and therefore
      /// has the very real possibility of exhausting the memory of the machine.  Use this method
      /// with discretion.
      /// @param expression The expression to evaluate, probably an ordered or unordered window expression
      std::vector<ScoredExtentResult> expressionList( const std::string& expression,
                                                      const std::string& queryType = "indri" );
      /// \brief Return the list of fields.
      /// @return vector of field names.
      std::vector<std::string> fieldList();
      /// \brief Return total number of documents in the collection.
      /// @return total number of documents in the aggregated collection
      INT64 documentCount();
      /// \brief Return total number of documents containing term in the collection.
      /// @param term the term to count documents for.
      /// @return total number of documents containing term in the aggregated collection
      INT64 documentCount( const std::string& term );

      /// \brief Return total number of documents containing stem in the collection.
      /// @param stem the prestemmed term to count documents for.
      /// @return total number of documents containing stem in the aggregated collection
      INT64 documentStemCount( const std::string& stem );

      /// \brief Return the length of a document.
      /// @param documentID the document id.
      /// @return length of the document, documentID
      int documentLength(lemur::api::DOCID_T documentID);

      /// \brief Fetch a document vector for a list of documents.
      /// Caller responsible for deleting the Vector.
      /// @param documentIDs the vector of document ids.
      /// @return DocumentVector pointer for the specified document.
      std::vector<DocumentVector*> documentVectors( const std::vector<lemur::api::DOCID_T>& documentIDs );

      /// \brief set maximum number of wildcard terms to expand to.
      /// @param maxTerms the maximum number of terms to expand a wildcard
      /// operator argument (default 100).
      void setMaxWildcardTerms(int maxTerms);

      /// \brief return the internal query servers.
      /// @return the local and network query servers.
      const std::vector<indri::server::QueryServer*>& getServers() const {
        return _servers;
      }

      /// \brief set the query reformulation parameters.
      /// @param p the Parameters object containing the parameters.
      void setFormulationParameters(Parameters &p);

      /// \brief reformulate a query.
      /// @param query the bag of words query to reformulate.
      /// @return the indri query language reformulated query.
      std::string reformulateQuery(const std::string &query);
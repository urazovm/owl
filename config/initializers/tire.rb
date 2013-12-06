TireListSettings = {
  analysis: {
    filter: {
      title_ngrams: {
        side: "front",
        max_gram: 20,
        min_gram: 2,
        type: "edgeNGram"
      }
    },
    analyzer: {
      full_title: {
        filter:    %w(standard lowercase asciifolding elision),
        type:      "custom",
        tokenizer: "letter"
      },
      partial_title: {
        filter:    %w(standard lowercase asciifolding elision title_ngrams),
        type:      "custom",
        tokenizer: "standard"
      },
      full_login: {
        filter:    %w(lowercase),
        type:      "custom",
        tokenizer: "keyword"
      }
    }
  }
}

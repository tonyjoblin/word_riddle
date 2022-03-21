# What 8 letter word can have a letter taken away and it still makes a word.
# Take another letter away and it still makes a word. Keep on doing that
# until you have one letter left. What is the word?

word_file = './big-word-list.txt'
TARGET_WORD_LENGTH = 4

word_container = {}

word_list = IO.readlines(word_file).map(&:chop).map(&:downcase)

def add_word(container, word)
  container[word.length] = {} unless container[word.length]
  container[word.length][word] = true
end

def add_words_to_container(container, words)
  words.each do |word|
    next if word.length > 8
    add_word(container, word)
  end
end

add_words_to_container(word_container, word_list)

def test_word(container, word)
  # puts "test #{word}"
  if word.length == 1
    # puts "Found #{word}"
    return word
  end

  next_word = word.slice(0, word.length - 1)
  # puts "next word #{next_word}"

  if container[next_word.length].key?(next_word)
    if test_word(container, next_word)
      # puts "Found #{word}"
      return word
    end
  end

  nil
end

# test_word(word_container, 'a')
# test_word(word_container, 'ad')
# test_word(word_container, 'at')

one_letter_words = word_container[1].map { |word, _| word }

# puts "one letter words #{one_letter_words}"

eight_letter_words_to_consider = word_container[8]
  .filter { |word, _| word.start_with?(*one_letter_words) }
  .map { |word, _| word }

# puts "8 letter words to consider #{eight_letter_words_to_consider}"

eight_letter_words_to_consider.each do |word|
  # puts "Consider #{word}"
  if test_word(word_container, word)
    puts "solution #{word}"
    # break
  end
end

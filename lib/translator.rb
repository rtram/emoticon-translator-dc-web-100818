# require modules here
require "pry"

def load_library (filepath)
  require "yaml"
  filepath_hash = YAML.load_file(filepath)
  
  dictionary = {}
  get_meaning = {}
  get_jap_emote = {}
  
  #create get_meaning hash where jap_emote => eng_meaning
  filepath_hash.each do |meaning, emotes|
    get_meaning[emotes[1]] = meaning
  end 
  #create get_jap_emote hash where eng_emote => jap_emote
  filepath_hash.each do |meaning, emotes|
    get_jap_emote[emotes[0]] = emotes[1]
  end 
  dictionary["get_meaning"] = get_meaning
  dictionary["get_emoticon"] = get_jap_emote

  return dictionary
end

def get_japanese_emoticon (filepath, emoticon)
  dictionary = load_library(filepath)
  sorry_message = "Sorry, that emoticon was not found"
  
  #check to see if emoticon is included in dictionary, if not return sorry_message
  if dictionary["get_emoticon"].keys.include? (emoticon)
  
    #iterate through dictionary to find matching emoticon and then return jap_emote
    dictionary.each do |translator, translation|
      if translator == "get_emoticon"
        translation.each do |eng_emote, jap_emote|
          if emoticon == eng_emote
            return jap_emote
          end 
        end 
      end 
    end 
  else 
    return sorry_message
  end 
end

def get_english_meaning (filepath, emoticon)
  dictionary = load_library(filepath)
  sorry_message = "Sorry, that emoticon was not found"
  
  #check to see if emoticon is included in dictionary, if not return sorry_message
  if dictionary["get_meaning"].keys.include? (emoticon)
  
    #iterate through dictionary to find matching emoticon and then return jap_emote
    dictionary.each do |translator, translation|
      if translator == "get_meaning"
        translation.each do |jap_emote, definition|
          if emoticon == jap_emote
            return definition
          end 
        end 
      end 
    end 
  else 
    return sorry_message
  end 
end
require "yaml"
require "openssl"
require "digest/md5"
require "securerandom"

module Helpers
  class Encryptor
    class DecryptError < StandardError; end

    def initialize(password)
      raise ArgumentError, "password must not be nil" \
        unless @password = password
    end

    # YAML used for serialization was not
    # picked for any specific purpose but convenience.
    def encrypt(plain_data)
      raise ArgumentError, "data must not be nil"  unless plain_data
      raise ArgumentError, "data must be a String" unless plain_data.is_a?(String)

      salt = SecureRandom.hex(10)
      md5 = Digest::MD5.hexdigest(plain_data)

      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = key(@password, salt)
      iv = cipher.random_iv # get random_iv before updating

      YAML.dump(
        data: cipher.update(plain_data) + cipher.final,
        salt: salt,
        iv: iv,
        md5: md5,
      )
    end

    def decrypt(encrypted_data)
      encrypted_data = YAML.load(encrypted_data)
      raise ArgumentError, "data must not be nil" unless data = encrypted_data[:data]
      raise ArgumentError, "salt must not be nil" unless salt = encrypted_data[:salt]
      raise ArgumentError, "iv must not be nil"   unless iv = encrypted_data[:iv]
      raise ArgumentError, "md5 must not be nil"  unless md5 = encrypted_data[:md5]

      decipher = OpenSSL::Cipher::AES256.new(:CBC)

      plain_data = begin
        decipher.decrypt
        decipher.key = key(@password, salt)
        decipher.iv = iv
        decipher.update(data) + decipher.final
      rescue OpenSSL::OpenSSLError => e
        raise DecryptError, e.message
      end

      unless Digest::MD5.hexdigest(plain_data) == md5
        raise DecryptError, "checksum check failed"
      end

      plain_data
    end

    private

    # WPA2 uses following iter and keylen
    # (http://en.wikipedia.org/wiki/PBKDF2)
    def key(password, salt)
      OpenSSL::PKCS5.pbkdf2_hmac_sha1(password, salt, 4_096, 256)
    end
  end
end

action = ARGV[0]
password = ARGV[1]
input_file = ARGV[2]
output_file = ARGV[3]

open(output_file, "w") { |f| f.write(Helpers::Encryptor.new(password).send(action, File.read(input_file))) }

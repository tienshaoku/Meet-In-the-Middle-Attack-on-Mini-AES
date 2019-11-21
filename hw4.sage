#!/usr/bin/sage -python
import sys
import math
from sage.all import *
from sage.crypto.util import ascii_to_bin
from sage.crypto.util import bin_to_ascii
from sage.crypto.block_cipher.miniaes import MiniAES

# find the keys
def decrypt(text, cipher):
    maes = MiniAES()
    bin = BinaryStrings()
    plain = ascii_to_bin(text)
    cipher = bin_to_ascii(cipher)
    cipher = ascii_to_bin(cipher)
    table = {}
    for x in range(0,16):
        for y in range(0,16):
            for z in range(0,16):
                for q in range(0,16):
                    key = [x,y,z,q]
                    key = maes.integer_to_binary(key)
                    encryption = maes(plain, key, algorithm="encrypt")
                    table[bin_to_ascii(encryption)] = key
#    print("First Half Done !!!!!!!!!!!!!!")
    for x in range(0,16):
        for y in range(0,16):
            for z in range(0,16):
                for q in range(0,16):
                    key = [x,y,z,q]
                    key = maes.integer_to_binary(key)
                    decryption = bin_to_ascii(maes(cipher, key, algorithm="decrypt"))
                    if decryption in table.keys():
                        k1 = table[decryption]
                        k2 = key
                        print("matched key1 in binary: " + str(table[decryption]))
                        print("matched key2 in binary: " + str(key))
                        print("key1 in ASCII: " + bin_to_ascii(table[decryption]))
                        print("key2 in ASCII: " + bin_to_ascii(key))
                        return (k1, k2)

# verify keys
def verify(text, cipher, k1, k2):
    maes = MiniAES()
    bin = BinaryStrings()
    plain = ascii_to_bin(text)
    cipher = bin_to_ascii(cipher)
    cipher = ascii_to_bin(cipher)
    k1 = maes.integer_to_binary(k1)
    k2 = maes.integer_to_binary(k2)
    encryption = bin_to_ascii(maes(plain, k1, algorithm="encrypt"))
    decryption = bin_to_ascii(maes(cipher, k2, algorithm="decrypt"))
    if encryption == decryption:
        return true
   
if __name__ == "__main__": 
    text = []
    cipher = []

    text.append("Network Security class is awesome!")
    text.append("Oh yeah! I Love NCKU, IIM~")
    text.append("Initial Impressions of the HTC 168")
    text.append("Mini-AES: A simplified variant of the Advanced Encryption Standard")
    text.append("Chien-Ming Wang KC")
    cipher.append("00100100011100101001010001011000110001100000001001100101000001010000000001100010110011111011000110101111011100011010010001010001010100001011011010111110000010101101111110110111011000001011010000001011010101100111101011000011000001011000100011110110100111111011101001001010")
    cipher.append("1111011010011101011001011100010010111110001010101011011110011010011001111100010011010111110000011101011000001100011010100100010101111000101101100010000110110010010110111001111011011100000100100000111101010011")
    cipher.append("00000111110100111100111011010111101101111101101001101011100101010100011111010010101101011100110000000101100010001010000001100001101001101001010100001011010101101101011010011100001101011100110111000011110100011000011111001110010100100000010110010011011100100111010110010000")
    cipher.append("110111001100001010010100011110011001000010000010011100111000011000010010111000111110001111111001101000000110000101101111010101011001111000001001100101111000100111001110001001110011010111001100110010101100001010110111110110101100100000000111001000001011011101101001111001011000111000011010011010100100010111010010100001011101011110001011000001000111100011001110001001110000011111001101000001000111100010101000001000010001010111000001000101111101010101100100100001011011111110111101101000101000010110111110000110100001111101110001")
    cipher.append("111100000110110111000111110100011111010010001111110111001100001001110100011100110110010000110011101000101000010101100111111001010111111111110110")
    
    (k1, k2) = decrypt(text[0], cipher[0])
    key1 = [int(str(k1[:4]),2), int(str(k1[4:8]),2), int(str(k1[8:12]),2), int(str(k1[12:]),2)]
    key2 = [int(str(k2[:4]),2), int(str(k2[4:8]),2), int(str(k2[8:12]),2), int(str(k2[12:]),2)]
    
    print("Verify the first (text,cipher) set: " + str(verify(text[0], cipher[0], key1, key2)))
    print("Verify the second (text,cipher) set: " + str(verify(text[1], cipher[1], key1, key2)))
    print("Verify the third (text,cipher) set: " + str(verify(text[2], cipher[2], key1, key2)))
    print("Verify the fourth (text,cipher) set: " + str(verify(text[3], cipher[3], key1, key2)))
    print("Verify the fifth (text,cipher) set: " + str(verify(text[4], cipher[4], key1, key2)))

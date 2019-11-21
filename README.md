# Network Security HW4

### Instruction (Linux or MacOs environment):
```
sage hw4.sage
```

![Result](result.png)


### Answer: 
```
The first key, k1
binary: 0101010100110011
ASCII: U3
```

```
The second key, k2
binary: 0100110100110111
ASCII: M7
```


### Explanations:

- **function decrypt()**
First decrypt the keys by inputing one of the (text,cipher) set. After getting the two keys, save them to variable *k1* and *k2*.

- **function verify**
Later, check if the values of **encrypting *text* with *k1*** and **decrypting *cipher* with *k2*** are equal.
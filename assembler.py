


op = {
    "stackset": {
        "opcode": "00000",
        "opcodeDec": 0,
        "type": "I"
        },
    "stackget": {
        "opcode": "00001",
        "opcodeDec": 1,
        "type": "I"
    },
    "accseti": {
        "opcode": "00010",
        "opcodeDec": 2,
        "type": "I"
        },
    "stackadd": {
        "opcode": "00011",
        "opcodeDec": 3,
        "type": "I"
    },
    "addi": {
        "opcode": "00100",
        "opcodeDec": 4,
        "type": "I"
        },
    "stacksub": {
        "opcode": "00101",
        "opcodeDec": 5,
        "type": "I"
        },
    "bne": {
        "opcode": "00110",
        "opcodeDec": 6,
        "type": "I"
    },
    "beq": {
        "opcode": "00111",
        "opcodeDec": 7,
        "type": "I"
    },
    "ble": {
        "opcode": "01000",
        "opcodeDec": 8,
        "type": "I"
    },
    "jal": {
        "opcode": "01001",
        "opcodeDec": 9,
        "type": "I"
    },
    "spinit": {
        "opcode": "01010",
        "opcodeDec": 10,
        "type": "I"
    },
    "sprelease": {
        "opcode": "01011",
        "opcodeDec": 11,
        "type": "I"
    },
    "jra": {
        "opcode": "01100",
        "opcodeDec": 12,
        "type": "N"
    },
    "accgetra": {
        "opcode": "01101",
        "opcodeDec": 13,
        "type": "N"
    },
    "ragetacc": {
        "opcode": "01110",
        "opcodeDec": 14,
        "type": "N"
    },
    
}



class Assembler:

    def __init__(self):
        #change file names to whatever yoru location is for the test and output files 
        self.i = open(r"C:\Users\farrelrn\Desktop\Fall2022\CSSE232\assembler\test.txt")
        self.f = open(r"C:\Users\farrelrn\Desktop\Fall2022\CSSE232\assembler\output.txt", "w")


    def parse(self):
        for line in self.i:
            # gets line of code 
            l = line.split(" ")
            l = line.split('\n')
            l = line.split(" ")
            print(l)
            #takes in line 
            i = self.assembleOp(l[0])

            if(i == 'error'):
                continue
            

            elif(i["type"]=="I"):

                s = bin(int(l[1]))
                s = s.split("b")
                s = s[1]
                

                instruction = {
                     "opcodeDec": i["opcodeDec"],
                     "opcode": i["opcode"],  
                     "immediate": s
                     }

                print(instruction)
                self.write("I", instruction)

            elif(i["type"]=="N"):
                instruction = {
                    "opcodeDec": i["opcodeDec"],
                }
                print(instruction)
                self.write("N", instruction)
            else:
                continue

            


    def addDecToHex(self, A, B):

        # Declaring the variables
        a = A
        b = B

        sum = a + b
        return hex(sum)

    


        
    

    def assembleOp(self, code):

        if(code == '\n'):
            return "error"
        else:
            print("current error")
            print(code)
            print(op[code])
            return (op[code])

    def write(self, instructionType, instruction):
        
        if(instructionType == "I"):

            # print("testing//////")
            # print(instruction["immediate"])
            # test = str(instruction["immediate"]) + str(instruction["opcode"])
            # print(test)


            binarytest= dec = int(instruction["immediate"]+"00000", 2)
            s = str(self.addDecToHex(binarytest, int(instruction["opcodeDec"])))
            print(s)

            s = s.split('x')
            s = s[1]
            s = (s.rjust(4,"0")).upper()
            
           
            self.f.write(s +  " \n")

        elif(instructionType == "N"):
            
            s = hex(instruction["opcodeDec"])
            s = s.split('x')
            s = s[1]
            s = (s.rjust(4,"0")).upper()

            self.f.write(s +  " \n")
            

    
    def close(self):
        self.f.close()



a = Assembler()

a.parse()



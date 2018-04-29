.data
press_1:.asciiz "\nplease, enter any number for (A):"
press_2:.asciiz "\nplease, enter any number for (B):"
press_3:.asciiz "\nplease, enter any number for (C):"
press_error:.asciiz "\n That is a complex root that will  give you complication stories. Enter a real number please "
press_ans:.asciiz "\n input\nYour answer is\n"
press_and:.asciiz "\nAnd\n"
press_question:.asciiz "\nwould you like to run another Quadratic Equation?\nBut remember not to use Complex Roots \n press 1 to continue or any key to exit\n"
press_goodbye:.asciiz "\nthanks for using DONFAVDEKING QUADRATIC CALCULATOR.enjoy the rest of your day\n "
press_two: .float 2
press_four: .float 4
discriminant_checker:.float 0

.text
loop:
lwc1 $f1,press_two                   #$f1 is holding 2.0
lwc1 $f2,press_four                  #$f2 is holding 4.0
lwc1 $f3,discriminant_checker       #$f3 is holding 0.0 i want to use it to check my discriminant

la $a0,press_1                       #Tell user to enter any number as A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f4,$f0                       #$f4 is holding A

la $a0,press_2                       #Tell user to enter any number as B
li $v0,4
syscall
li $v0,6
syscall
mov.s $f5,$f0                       #$f5 is holding B

la $a0,press_3                       #Tell user to enter any number as C
li $v0,4
syscall
li $v0,6
syscall
mov.s $f6,$f0                       #$f6 is holding C

#ijust started calculating my discriminant which is ## d = b^2-4*a*c
#And my 4=$f2, a=$f4, b=$f5, c=$f6

mul.s $f7,$f5,$f5                  #$f7 = b^2
mul.s $f8,$f2,$f4                  
mul.s $f8,$f8,$f6                  #$f8 = 4*a*c
sub.s $f8,$f7,$f8                  #$f8 = d = b^2-4*a*c#$f9 = d = b^2-4*a*c
mfc1 $t1,$f8                       #i changed $f8 to $t1 so i can check if my discriminat is smaller than zero(0)

blez $t1,error_label               #i want to check if the discriminant is  smaller than zero or equal to zero
sqrt.s $f10,$f8                    #$f10 is holding the square root of the discriminant

#roots_solver                      #we can now start calculation which is ## -b+-sqrtd/2*a
neg.s $f9,$f5                      # i just change b to -b. like this $f9=-b
add.s $f23,$f9,$f10                # i just did small -b+sqrtd
sub.s $f25,$f9,$f10                # i just did small -b-sqrtd
mul.s $f1,$f1,$f4                  #its just 2*a i wrote for 
div.s $f24,$f23,$f1                #I then  divided -b+sqrtd by 2*a
div.s $f26,$f25,$f1                #I then divided -b-sqrtd by 2*a
la $a0,press_ans
li $v0,4
syscall

mov.s $f12,$f24
li $v0,2
syscall

la $a0,press_and
li $v0,4
syscall

mov.s $f12,$f26
li $v0,2
syscall

la $a0,press_question
li $v0,4
syscall
li $v0,5
syscall
move $t4,$v0
li $t3,1
beq $t4,$t3,loop
b exit

error_label:
la $a0,press_error
li $v0,4
syscall

la $a0,press_question
li $v0,4
syscall
li $v0,5
syscall
move $t4,$v0
li $t3,1
beq $t4,$t3,loop

b exit
exit:
la $a0,press_goodbye
li $v0,4
syscall

li $v0,10
syscall

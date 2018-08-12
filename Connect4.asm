.data
	prompt:		.asciiz "\nEnter Number: "
	
.text		
 	main: 
 		li $v0, 4			#Prompt for Input
		la $a0, prompt		
		syscall			
	
		li $v0, 5			#Read Menu option selected
		syscall			
	
		beq $v0, 1, setSize     	#branch based on selected command	
		beq $v0, 2, calculate     
		beq $v0, 3, exit        
		    
		    
	setSize: 
		li $v0, 4			#Prompt to select size
		la $a0, promptSizes	
		syscall
		
		li $v0, 5			#Read size option
		syscall 
		
		beq $v0, 1, setSmall		#branch based on selected command	
		beq $v0, 2, setLarge		
		beq $v0, 3, main	
		
		
	setSmall:
		li $v0, 4			#Prompt to set small size
		la $a0, promptSize	
		syscall
		
		li $v0, 6			#Read radius
		syscall 
		swc1 $f0, radiusS
		
		lwc1 $f5, radiusS
	
		j setSize
		
		
	setLarge:
		li $v0, 4			#Prompt to set large size
		la $a0, promptSize	
		syscall
		
		li $v0, 6			#Read radius
		syscall 
		swc1 $f0, radiusL
		
		lwc1 $f6, radiusL
		
		j setSize
	
	
	calculate:	
		li $v0, 4			#Prompt number of small slices
		la $a0, promptSlicesS	
		syscall
		li $v0, 6		
		syscall 
		mov.s $f8, $f0			#move number of small slices into fp register
			
		li $v0, 4			#Prompt number of Large slices
		la $a0, promptSlicesL	
		syscall
		li $v0, 6		
		syscall 
		mov.s $f9, $f0			#move number of large slices into fp register
		
		mul.s $f10, $f5, $f5		#calculate area for small slices eaten
		mul.s $f10, $f10, $f4		
		div.s $f10, $f10, $f7
		mul.s $f10, $f10, $f8
		
		mul.s $f11, $f6, $f6		#calculate area for large slices eaten
		mul.s $f11, $f11, $f4		
		div.s $f11, $f11, $f7
		mul.s $f11, $f11, $f9
		
		add.s $f11, $f11, $f10
		
		swc1 $f11, area
		
		li $v0, 2			#print the result string
		lwc1 $f12, area
		syscall
		j main
	
	exit:

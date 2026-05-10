.model small
.stack 100h

.data
;******************************************************************
menu db 13,10,'***** Secure Voting System *****',13,10 
     db '1. Vote',13,10
     db '2. Admin Results',13,10
     db '3. Exit',13,10
     db 'Choose: $'      
;*******************************************************************

voteMsg db 13,10,'Enter Voter ID: $'

candMsg db 13,10,'Choose Candidate:',13,10
        db '1. Alaa',13,10
        db '2. Sarah',13,10
        db 'Your Vote: $'  
        
wrongChoiceMsg    db 13,10,'Invalid choice plz enter 1 or 2 again , $'
successMsg db 13,10,'Vote Recorded Successfully!$'

AlaaVotes db 0
sarahVotes  db 0

votedIDs   db 20 dup(0)    
voteCount  db 0

duplicateMsg db 13,10,'You Already Voted!$'

resultsMsg   db 13,10,'===== Results =====',13,10,'$'
AlaaMsg     db 13,10,'Alaa Votes: $'
sarahMsg      db 13,10,'Sarah Votes: $'

winnerMsg db 13,10,'===== WINNER =====',13,10,'$'
AlaaWin  db 13,10,'* Alaa Wins *',13,10,'$'
sarahWin   db 13,10,'* Sarah Wins *',13,10,'$'
drawMsg   db 13,10,'* It is a Draw *',13,10,'$'

;Admin Password
passMsg   db 13,10,'Enter Admin Password: $'
wrongMsg  db 13,10,'Wrong Password!$'
adminPass db '1','2','3','4'
password_input db 4 dup(0)
;******************************************************************
startSecond db 0
timerFlag  db 0   
closedMsg  db 13,10,'Voting time finished!$'
;******************************************************************

.code
main proc
    mov ax,@data
    mov ds,ax

start:
     ;print menue
    lea dx,menu
    mov ah,9
    int 21h
     ;wait input
    mov ah,1
    int 21h

    cmp al,'1'
    je vote_module

    cmp al,'2'
    je admin_module

    cmp al,'3'
    je exit_program

    jmp start

;******************************************************************
vote_module:
    
continue_vote:
    lea dx,voteMsg
    mov ah,9
    int 21h

    mov ah,1
    int 21h
    mov bl,al ;enter id 

    ; check duplicate
    mov si,0    ;si pointer to array 
    mov cl,voteCount
    mov ch,0


    
check_loop:
    cmp si,cx     ; cx : no people that voted 
    ; if we arrived at the end of list so no duplication
    je not_duplicate ;

    mov al,votedIDs[si] ;id old from array
    cmp al,bl        ; compare old id with new
    je duplicate_vote ;   duplicate

    inc si
    jmp check_loop  ;complete loop then increment pointer

duplicate_vote:
    lea dx,duplicateMsg
    mov ah,9
    int 21h  
    jmp start

not_duplicate:
    
    mov al,voteCount
    mov ah,0       
    mov si,ax      ;si=index that store in it
    mov votedIDs[si],bl  ;put new id in that index
    inc voteCount


   cand_loop:

    lea dx, candMsg
    mov ah,9
    int 21h

    mov ah,1
    int 21h

    cmp al,'1'
    je vote_Alaa

    cmp al,'2'
    je vote_sarah

    ; ?? ??? ???? ???
    lea dx, wrongChoiceMsg
    mov ah,9
    int 21h

    jmp cand_loop                                                                     

vote_Alaa:
    inc AlaaVotes
    jmp vote_done

vote_sarah:
    inc sarahVotes
    jmp vote_done

vote_done:
    lea dx,successMsg
    mov ah,9
    int 21h
    jmp start

;******************************************************************
admin_module:

    mov cx,3              ; 3 attempts

password_loop:

    lea dx,passMsg
    mov ah,9
    int 21h

    ; ===== read 4-digit password =====
    mov si,0

read_pass:
    mov ah,8
    int 21h

    mov password_input[si],al

    mov dl,'*'
    mov ah,2
    int 21h

    inc si
    cmp si,4
    jne read_pass
    ; ===== compare =====
    mov si,0

check_pass:
    mov al,password_input[si]
    cmp al,adminPass[si]
    jne wrong_password
    inc si
    cmp si,4
    jne check_pass

    jmp correct_password

wrong_password:
    lea dx,wrongMsg
    mov ah,9
    int 21h
    loop password_loop
    jmp start


correct_password:

    ; ===== Results =====
    lea dx,resultsMsg
    mov ah,9
    int 21h

    lea dx,AlaaMsg
    mov ah,9
    int 21h

    mov dl,AlaaVotes
    add dl,48
    mov ah,2
    int 21h

    lea dx,sarahMsg
    mov ah,9
    int 21h

    mov dl,sarahVotes
    add dl,48
    mov ah,2
    int 21h
    

    ; ===== Winner Check =====
    lea dx,winnerMsg
    mov ah,9
    int 21h

    mov al, AlaaVotes
    mov bl, sarahVotes

    cmp al, bl
    jg Alaa_wins
    jl sarah_wins

    lea dx, drawMsg
    mov ah,9
    int 21h
    jmp start

Alaa_wins:
    lea dx, AlaaWin
    mov ah,9
    int 21h
    jmp start

sarah_wins:
    lea dx, sarahWin
    mov ah,9
    int 21h
    jmp start

;******************************************************************
exit_program:
    mov ah,4ch
    int 21h

main endp
end main
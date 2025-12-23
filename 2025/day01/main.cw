let buf = rb 4096

let other = 'a'T
let other2 = 'a'TA
let other3 = /asd/TAG

let something = 'abc' 'def'

let somethingelse = 'abc' 10
let shortstr = 'abc'

let left = 'L'_ /[0-9]{1,2}/LEFT
let left2 = re.delay left 10

let right = 'R'_ /[0-9]{1,2}/RIGHT
let right2 = re.delay right 10

let instruction = left2 | right2

let line = instruction 
let lines = line+

let prev = rb 8
let sum = rb 8

let str = 'result: %d' 10

let atoi_tmp = rb 8
let atoi = (ptr:ptr, len:pos): { 
    mov atoi_tmp 0
    iter ptr len (v:byte): {
        let integer = sub v 48
        let arg1 = mul 10 atoi_tmp
        let arg2 = add integer arg1
        mov atoi_tmp arg2
    }
    atoi_tmp
}


let main = {
    mov sum 51
    let fd = open_read 'small'
    check fd
    let n_read = read fd buf
    re.lex lines &buf n_read (pos,tag): {
        jump tag {
            _: { mov prev pos }            
            LEFT: {
                let len = sub pos prev
                let ptr = add &buf prev
                let result = atoi &ptr len
                printf 'left: [%d]' result
                // print &ptr len
            }
            RIGHT: { 
                let len = sub pos prev
                let ptr = add &buf prev
                print &ptr len
            }
        }
    }
    let newline = '' 10
    printf newline 1
    print 'nice '
}
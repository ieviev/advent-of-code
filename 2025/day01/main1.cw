let buf = rb 4096

let other = 'a'T
let other2 = 'a'TA
let other3 = /asd/TAG

let something = 'abc' 'def'

let somethingelse = 'abc' 10
let shortstr = 'abc'

// R = '_*cab_*'

// deflate
// -> huffman
// -> lz77
// R2: 'a' 'b' 'c' (3,2) ... ... (11,2) 

// if R is nullable: match exists
// else: 
// R = R & a_*
// R = R & b_*
// R = R & c_*
// R = R & [(3,2)]_*

// -- 
// 'a': '_*cab_*' -> '_*cab_*' 
// 'a': '_*cab_*' -> '_*cab_*' 


let left = 'L'_ /[0-9]{1,2}/LEFT
let left2 = re.delay left 10

let right = 'R'_ /[0-9]{1,2}/RIGHT
let right2 = re.delay right str.lf

let instruction = left2 | right2

let line = instruction 
let lines = line+

let prev = rb 8
let sum = rb 8

let main = {
    mov sum 51
    let fd = open_read 'small'
    check fd
    let n_read = read fd buf
    lines.lex &buf n_read (pos,tag): {
        jump tag {
            _: { mov prev pos }
            LEFT: {
                let len = sub pos prev
                let ptr = add &buf prev
                print 'LEFT:['
                print &ptr len
                print ']'
            }
            RIGHT: { 
                let len = sub pos prev
                let ptr = add &buf prev
                print &ptr len
            }
        }
    }
    print 'nice'
}

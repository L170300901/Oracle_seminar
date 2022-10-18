-- 대문자 -> 소문자
select 'ABcdEF', lower('ABcdEF') from dual;

-- 사원들의 이름을 소문자로 가져온다.
select ename, lower(ename)
from emp;

-- 소문자 --> 대문자
select 'ABcdEF', upper('ABcdEF') from dual;

-- 사원들의 이름을 가져온다. 대문자 -> 소문자 -> 대문자
select ename, lower(ename), upper(lower(ename))
from emp;

-- 첫 글자만 대문자로, 나머지는 소문자로
select 'aBCDEF', initcap('aBCDEF') from dual;

-- 사원이름을 첫 글자는 대문자로 나머지는 소문자로 가져온다.
select ename, initcap(ename)
from emp;

-- 문자열 연결

select concat(concat('kkk', concat('abc', 'def')), 'zzz')
from dual;

-- 사원들의 이름과 직무를 다음과 같이 가져온다.
-- 사원의 이름은 000 이고, 직무는 000입니다

select concat(concat(concat(concat('사원의 이름은 ', ename), ' 이고, 직무는 '), job), '입니다')
from emp;

select '사원들의 이름은 ' || ename || '이고, 직무는 ' || job || '입니다'
from emp;

-- 문자열의 길이
select length('abcd'), lengthb('abcd'), length('안녕하세요'), lengthb('안녕하세요') from dual;

-- 문자열 잘라내기
select substr('abcd', 3), substrb('abcd', 3),
       substr('안녕하세요', 3), substrb('안녕하세요', 3)       
from dual;

select substr('abcdefghi', 3, 4), substr('동해물과 백두산이', 3, 4) from dual;

-- 문자열 찾기***
select instr('abcdabcdabcd', 'bc'), instr('abcdabcdabcd', 'bc', 3),
       instr('abcdabcdabcd', 'bc', 3, 2)
from dual;

select instr('abcdefg', 'aaa') from dual;

-- 사원의 이름 중에 A라는 글자가 두번째 이후에 나타나는 사원의 이름을 가져온다.***
select ename
from emp
where instr(ename, 'A') > 1;

-- 특정 문자열로 채우기
select '문자열', lpad('문자열', 20), rpad('문자열', 20), 
       lpad('문자열', 20, '_'), rpad('문자열', 20, '_') from dual;
       
-- 공백 제거
select '       문자열       ', ltrim('       문자열       '), rtrim('       문자열       '),
       trim('       문자열       ')
from dual;

-- 문자열 변경
select 'abcdefg', replace('abcdefg', 'abc', 'kkkkkkk') from dual;














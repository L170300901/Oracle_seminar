-- ����߿� Ŀ�̼��� ���� �ʴ� ����� �����ȣ, �̸�, Ŀ�̼��� �����´�.
select empno, ename, comm
from emp
where comm is null;

select empno, ename, comm
from emp
where comm is not null;

-- ȸ�� ��ǥ(���ӻ���� ���� ���)�� �̸��� �����ȣ�� �����´�.

select ename, empno
from emp
where mgr is null;

select ename, empno
from emp
where mgr is not null;












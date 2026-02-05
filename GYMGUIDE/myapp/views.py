import smtplib
from datetime import datetime

import numpy as np
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

# Create your views here.
from myapp.models import *


def loginget(request):
    request.session['lid']=''
    return render(request,'loginindex.html')

def loginpost(request):
    username=request.POST['textfield']
    password=request.POST['textfield2']
    log=Login.objects.filter(username=username,password=password)
    if log.exists():
        log1 = Login.objects.get(username=username, password=password)
        request.session['lid']=log1.id
        if log1.type=="admin":
            return HttpResponse('''<script>alert('Login Successfull');window.location="/myapp/admin_home/"</script>''')
        elif log1.type=="trainer":

            return HttpResponse('''<script>alert('Login Successfull');window.location="/myapp/trainer_home/"</script>''')


        elif log1.type=="pending":

            return HttpResponse('''<script>alert('Please Wait For Approval');window.location="/myapp/login/"</script>''')

        else:
            return HttpResponse('''<script>alert('User Not Found');window.location="/myapp/login/"<script>''')
    else:
        return HttpResponse('''<script>alert('User Invalid');window.location="/myapp/login/"<script>''')

def logout(request):
    request.session['lid']=''
    return render(request,'loginindex.html')

###########admin



def admin_home(request):
    if request.session['lid']=='':
        return render(request, 'loginindex.html')
    return render(request,'admin/homeindex.html')




def admin_viewtrainerget(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Trainer.objects.filter(status='pending')
    return render(request,'admin/viewtrainer.html',{"data":res})


def admin_viewtrainerpost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    search=request.POST['textfield']
    res = Trainer.objects.filter(name__icontains=search,status='pending')
    return render(request,'admin/viewtrainer.html',{"data": res})




def admin_viewapprovedtrainerget(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Trainer.objects.filter(status='approved')
    return render(request,'admin/viewapprovedtrainer.html',{"data":res})


# def admin_viewapprovedtrainerpost(request):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     search=request.POST['textfield']
#     res = Trainer.objects.filter(name__icontains=search,status='approved')
#     return render(request,'admin/viewapprovedtrainer.html',{"data": res})
#
def admin_viewapprovedtrainerpost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')

    name = request.POST.get('name', '').strip()
    specialization = request.POST.get('specialization', '').strip()
    experience = request.POST.get('experience', '').strip()

    res = Trainer.objects.filter(status='approved')

    if name:
        res = res.filter(name__icontains=name)
    if specialization:
        res = res.filter(specialization__icontains=specialization)

    if experience:
        if experience == 'more_than_5':
            res = res.filter(experience__gt=5)
        else:
            try:
                exp_value = int(experience)
                res = res.filter(experience__lte=exp_value)
            except ValueError:
                pass  # Ignore invalid input like a string

    return render(request, 'admin/viewapprovedtrainer.html', {"data": res})


def admin_viewrejectedtrainerget(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Trainer.objects.filter(status='rejected')
    return render(request,'admin/viewrejectedtrainer.html',{"data":res})


def admin_viewrejectedtrainerpost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    search=request.POST['textfield']
    res = Trainer.objects.filter(name__icontains=search,status='approved')
    return render(request,'admin/viewrejectedtrainer.html',{"data":res})


def approve_trainer(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Trainer.objects.filter(LOGIN=id).update(status='approved')
    Login.objects.filter(id=id).update(type='trainer')
    return HttpResponse('''<script>alert('Approved Successfully');window.location="/myapp/admin_viewtrainer/"</script>''')



def reject_trainer(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Trainer.objects.filter(LOGIN=id).update(status='rejected')
    Login.objects.filter(id=id).update(type='rejected')
    return HttpResponse('''<script>alert('Rejected Successfully');window.location="/myapp/admin_viewtrainer/"</script>''')




def admin_viewuser(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=User.objects.all()
    return render(request,'admin/viewuser.html',{"data":res})


def admin_viewuserpost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    search = request.POST.get('textfield', '')
    res = User.objects.filter(name__icontains=search)
    return render(request, 'admin/viewuser.html', {"data": res})




def admin_facility(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request,'admin/addfacility.html')

def admin_facilitypost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Equipment=request.POST['Equipment']
    Quantity=request.POST['Quantity']
    Condition=request.POST['Condition']
    photo=request.FILES['photo']

    fs = FileSystemStorage()
    date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
    fn = fs.save(date, photo)
    path = fs.url(date)

    sobj=Facility()
    sobj.equipment_name=Equipment
    sobj.quantity=Quantity
    sobj.maintanance_status=Condition
    sobj.photo=path
    sobj.save()
    return HttpResponse('''<script>alert('Facility Added Successfull');window.location="/myapp/admin_home/"</script>''')



def admin_viewfacilityget(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Facility.objects.all()
    return render(request,'admin/viewfacility.html',{"data":res})

def admin_viewfacilitypost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    search=request.POST['search']
    res = Facility.objects.filter(equipment_name__icontains=search)
    return render(request, 'admin/viewfacility.html', {"data": res})


def admin_editfacility(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Facility.objects.get(id=id)
    return render(request,'admin/editfacility.html',{"data":res})


def admin_editfacilitypost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Equipment = request.POST['Equipment']
    Quantity = request.POST['Quantity']
    Condition = request.POST['Condition']
    id = request.POST['id']

    sobj = Facility.objects.get(id=id)


    if 'photo' in request.FILES:
        photo = request.FILES['photo']

        fs = FileSystemStorage()
        date = datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
        fn = fs.save(date, photo)
        path = fs.url(date)
        sobj.photo=path
        sobj.save()
    sobj.equipment_name = Equipment
    sobj.quantity = Quantity
    sobj.maintanance_status = Condition
    sobj.save()
    return HttpResponse('''<script>alert('Successfull');window.location="/myapp/admin_viewfacilityget/"</script>''')

def delete_facility(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Facility.objects.get(id=id).delete()
    return HttpResponse('''<script>alert('Delete Successfull');window.location="/myapp/admin_viewfacilityget/"</script>''')



# def admin_serviceplanget(request):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     return render(request,'admin/serviceplan.html')
#
# # def admin_serviceplanpost(request):
# #     if request.session['lid'] == '':
# #         return render(request, 'loginindex.html')
# #     plan=request.POST['select']
# #     amnt=request.POST['nbr']
# #     dur=request.POST['dur']
# #
# #     sobj=Serviceplan()
# #     sobj.Splan=plan
# #     sobj.amount=amnt
# #     sobj.duration=dur
# #     sobj.save()
# #     return HttpResponse('''<script>alert('Successfull');window.location="/myapp/admin_home/"</script>''')
# def admin_serviceplanpost(request):
#     if request.session.get('lid') == '':
#         return render(request, 'loginindex.html')
#
#     plan = request.POST['plan']
#     amount = request.POST['amount']
#     duration = request.POST['duration']
#
#     free_riding = 'free_riding' in request.POST
#     unlimited_equipment = 'unlimited_equipment' in request.POST
#     personal_trainer = 'personal_trainer' in request.POST
#     weight_loss_classes = 'weight_loss_classes' in request.POST
#     group_classes = 'group_classes' in request.POST
#     swimming_pool_access = 'swimming_pool_access' in request.POST
#     sauna_access = 'sauna_access' in request.POST
#     nutrition_plan = 'nutrition_plan' in request.POST
#
#     sobj = Serviceplan(
#         Splan=plan,
#         amount=amount,
#         duration=duration,
#         free_riding=free_riding,
#         unlimited_equipment=unlimited_equipment,
#         personal_trainer=personal_trainer,
#         weight_loss_classes=weight_loss_classes,
#         group_classes=group_classes,
#         swimming_pool_access=swimming_pool_access,
#         sauna_access=sauna_access,
#         nutrition_plan=nutrition_plan
#     )
#     sobj.save()
#
#     return HttpResponse('''<script>alert('Service Plan Added Successfully');window.location="/myapp/admin_home/"</script>''')
#
#
#
# def admin_viewserviceplanget(request):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     res=Serviceplan.objects.all()
#     return render(request,'admin/viewservice.html',{"data":res})
#
# def admin_viewserviceplanpost(request):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     search=request.POST['search']
#     res = Serviceplan.objects.filter(Splan__icontains=search)
#     return render(request, 'admin/viewservice.html', {"data": res})
#
#
#
# def admin_editservice(request,id):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     res=Serviceplan.objects.get(id=id)
#     return render(request,'admin/editserviceplan.html',{"data":res})
#
#
#
# def admin_editservicepost(request):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     plan=request.POST['select']
#     amnt=request.POST['nbr']
#     dur=request.POST['dur']
#     sid=request.POST['sid']
#     sobj = Serviceplan.objects.get(id=sid)
#     sobj.Splan=plan
#     sobj.amount=amnt
#     sobj.duration=dur
#     sobj.save()
#     return HttpResponse('''<script>alert('Successfull');window.location="/myapp/admin_viewserviceplanget/#id"</script>''')
#
# def delete_serviceplan(request,id):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     res=Serviceplan.objects.filter(id=id).delete()
#     return HttpResponse('''<script>alert('Delete Successfull');window.location="/myapp/admin_viewserviceplanget/#id"</script>''')
#
from django.shortcuts import redirect, render, get_object_or_404
from django.contrib import messages

def admin_serviceplanget(request):
    if not request.session.get('lid'):
        return render(request, 'loginindex.html')
    return render(request, 'admin/serviceplan.html')

def admin_serviceplanpost(request):
    if not request.session.get('lid'):
        return render(request, 'loginindex.html')

    plan = request.POST['plan']
    amount = request.POST['amount']
    duration = request.POST['duration']

    free_riding = 'free_riding' in request.POST
    unlimited_equipment = 'unlimited_equipment' in request.POST
    personal_trainer = 'personal_trainer' in request.POST
    weight_loss_classes = 'weight_loss_classes' in request.POST
    group_classes = 'group_classes' in request.POST
    swimming_pool_access = 'swimming_pool_access' in request.POST
    sauna_access = 'sauna_access' in request.POST
    nutrition_plan = 'nutrition_plan' in request.POST

    sobj = Serviceplan(
        Splan=plan,
        amount=amount,
        duration=duration,
        free_riding=free_riding,
        unlimited_equipment=unlimited_equipment,
        personal_trainer=personal_trainer,
        weight_loss_classes=weight_loss_classes,
        group_classes=group_classes,
        swimming_pool_access=swimming_pool_access,
        sauna_access=sauna_access,
        nutrition_plan=nutrition_plan
    )
    sobj.save()

    messages.success(request, 'Service Plan Added Successfully')
    return redirect('/myapp/admin_home/')

def admin_viewserviceplanget(request):
    if not request.session.get('lid'):
        return render(request, 'loginindex.html')
    res = Serviceplan.objects.all()
    return render(request, 'admin/viewservice.html', {"data": res})

def admin_viewserviceplanpost(request):
    if not request.session.get('lid'):
        return render(request, 'loginindex.html')
    search = request.POST['search']
    res = Serviceplan.objects.filter(Splan__icontains=search)
    return render(request, 'admin/viewservice.html', {"data": res})

def admin_editservice(request, id):
    if not request.session.get('lid'):
        return render(request, 'loginindex.html')
    res = get_object_or_404(Serviceplan, id=id)
    return render(request, 'admin/editserviceplan.html', {"data": res})

def admin_editservicepost(request):
    if not request.session.get('lid'):
        return render(request, 'loginindex.html')
    plan = request.POST['select']
    amnt = request.POST['nbr']
    dur = request.POST['dur']
    sid = request.POST['sid']
    sobj = get_object_or_404(Serviceplan, id=sid)
    sobj.Splan = plan
    sobj.amount = amnt
    sobj.duration = dur
    sobj.save()

    messages.success(request, 'Service Plan Updated Successfully')
    return redirect('/myapp/admin_viewserviceplanget/')

def delete_serviceplan(request, id):
    if not request.session.get('lid'):
        return render(request, 'loginindex.html')
    Serviceplan.objects.filter(id=id).delete()
    messages.success(request, 'Service Plan Deleted Successfully')
    return redirect('/myapp/admin_viewserviceplanget/')


def admin_viewclassplan(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Classes.objects.all()
    return render(request, "admin/viewclassplan.html",{"data":res})


def add_attendance_request(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    cls = Classes.objects.get(id=id).REQUEST.id
    res=Request.objects.filter(id=cls)
    return render(request,'admin/viewrequest.html',{'data':res})



def admin_add_attendance(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    request.session['cid']=id
    return render(request,'admin/add attendance.html',{'id':id})

def admin_add_attendance_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    checkin=request.POST['checkin']
    checkout=request.POST['checkout']
    date=datetime.datetime.now().today()
    user=request.POST['uid']
    status='present'
    obj=Attendance()
    obj.date=date
    obj.USER_id=user
    obj.CLASS_id=request.session['cid']
    obj.checkintime=checkin
    obj.checkouttime=checkout
    obj.status=status
    obj.save()
    return HttpResponse('''<script>alert('Added Successfull');window.location="/myapp/admin_home/"</script>''')

def admin_viewuserpayments(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Payment.objects.all()
    return render(request,'admin/viewuserpayments.html',{"data":res})
#
# def admin_viewuserpayments_post(request):
#     if request.session['lid'] == '':
#         return render(request, 'loginindex.html')
#     fromdate=request.POST['textfield']
#     todate=request.POST['textfield2']
#     res = Payment.objects.filter(date__range=[fromdate,todate])
#     return render(request,'admin/viewuserpayments.html',{"data":res})
def admin_viewuserpayments_post(request):
    if request.session.get('lid') == '':
        return render(request, 'loginindex.html')

    # Get values safely
    fromdate = request.POST.get('from_date', '')  # Use get() to avoid errors
    todate = request.POST.get('to_date', '')

    if not fromdate or not todate:  # Handle missing input
        return HttpResponse("Please provide both from and to dates.")

    try:
        res = Payment.objects.filter(date__range=[fromdate, todate])
    except Exception as e:
        return HttpResponse(f"Error fetching payments: {e}")

    return render(request, 'admin/viewuserpayments.html', {"data": res})



def admin_viewcomplaintandsendreply(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Complaint.objects.all()
    return render(request,'admin/viewcomplaintandsendreply.html',{"data":res})

def admin_viewcomplaintandsendreply_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    fromdate=request.POST['textfield']
    todate=request.POST['textfield2']
    res = Complaint.objects.filter(date__range=[fromdate,todate])
    return render(request, 'admin/viewcomplaintandsendreply.html', {"data": res})



def admin_sendreply(request,cid):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request,'admin/sendreply.html',{"cid":cid})

def admin_sendreply_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    reply=request.POST['textarea']
    cid=request.POST['cid']

    Complaint.objects.filter(id=cid).update(reply=reply,status="replied")
    return HttpResponse(
        '''<script>alert('Sending Successfull');window.location="/myapp/admin_viewcomplaintandsendreply/"</script>''')


def admin_viewreview(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Review.objects.all()
    return render(request,'admin/viewreviews.html',{"data":res})


def admin_viewreview_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    fromdate=request.POST['fdate']
    Todate=request.POST['tdate']
    res = Review.objects.filter(date__range=[fromdate,Todate])
    return render(request, 'admin/viewreviews.html', {"data": res})


def admin_changepassword(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request,'admin/changepassword.html')

def admin_changepassword_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    currentpassword=request.POST['textfield']
    newpassword=request.POST['textfield2']
    confirmpassword=request.POST['textfield3']
    res=Login.objects.filter(id=request.session['lid'],password=currentpassword)
    if res.exists():
        if newpassword==confirmpassword:
            res = Login.objects.filter(id=request.session['lid'], password=currentpassword).update(password=confirmpassword)
            return HttpResponse(
                '''<script>alert('Changed Successfully');window.location="/myapp/login/"</script>''')
        else:
            return HttpResponse(
                '''<script>alert('password mismatched');window.location="/myapp/admin_changepassword/"</script>''')
    else:
        return HttpResponse(
            '''<script>alert('Invalid');window.location="/myapp/admin_changepassword/"</script>''')

def admin_view_progress(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res = Progress.objects.filter(USER_id=id)
    return render(request, 'admin/viewuserprogress.html', {"data": res})


################trainer


def trainer_view_progress(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res = Progress.objects.filter(WORKOUTPLAN_id=id)
    return render(request, 'trainer/viewuserprogress.html', {"data": res})


def triner_signupget(request):
    return render(request,'trainer/signup.html')

def triner_signuppost(request):
    name=request.POST['textfield']
    phone=request.POST['textfield2']
    email=request.POST['textfield3']
    qualification=request.POST['textfield4']
    gender=request.POST['RadioGroup1']
    dob=request.POST['textfield5']
    photo=request.FILES['fileField']
    certificate=request.FILES['fileField2']
    experience=request.POST['textfield6']
    specialization=request.POST['specialization']


    fs = FileSystemStorage()
    date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
    fn = fs.save(date, photo)
    path = fs.url(date)

    cfs = FileSystemStorage()
    cdate = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".pdf"
    cfn = cfs.save(cdate, certificate)
    cpath = cfs.url(cdate)

    if Login.objects.filter(username=email).exists():
        return HttpResponse('''<script>alert('trainer email already exists');window.location="/myapp/triner_signupget/"</script>''')

    new_pass = request.POST['password']
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login("safedore3@gmail.com", "yqqlwlyqbfjtewam")  # App Password
    to = email
    subject = "Test Email"
    body = "Your new password is " + str(new_pass),"Your new username is " + str(email)
    msg = f"Subject: {subject}\n\n{body}"
    server.sendmail("s@gmail.com", to, msg)  # Disconnect from the server
    server.quit()

    Log=Login()
    Log.username=email
    Log.password=new_pass
    Log.type="pending"
    Log.save()

    tobj=Trainer()
    tobj.LOGIN=Log
    tobj.name=name
    tobj.phone=phone
    tobj.email=email
    tobj.qualification=qualification
    tobj.specialization=specialization
    tobj.certificate=cpath
    tobj.gender=gender
    tobj.dob=dob
    tobj.photo=path
    tobj.experience=experience
    tobj.status='pending'
    tobj.save()

    return HttpResponse('''<script>alert('Successfull');window.location="/myapp/login/"</script>''')


def edit_trainer_profile(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Trainer.objects.get(LOGIN=request.session['lid'])
    return render(request,'trainer/editprofile.html',{'data':res})

def edit_trainer_profile_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    name=request.POST['textfield']
    phone=request.POST['textfield2']
    email=request.POST['textfield3']
    qualification=request.POST['qualification']
    gender=request.POST['RadioGroup1']
    dob=request.POST['textfield5']
    experience=request.POST['textfield6']
    specialization=request.POST['spec']
    Log = Login.objects.get(id=request.session['lid'])
    Log.username = email

    Log.save()

    tobj = Trainer.objects.get(LOGIN=request.session['lid'])

    if 'fileField' in request.FILES:
        photo = request.FILES['fileField']

        fs = FileSystemStorage()
        date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
        fn = fs.save(date, photo)
        path = fs.url(date)
        tobj.photo = path
        tobj.save()

    if 'fileField2' in request.FILES:
        certificate = request.FILES['fileField2']

        cfs = FileSystemStorage()
        cdate = datetime.now().strftime("%Y%m%d%H%M%S") + ".pdf"
        cfn = cfs.save(cdate, certificate)
        cpath = cfs.url(cdate)
        tobj.certificate = cpath
        tobj.save()

    tobj.LOGIN=Log
    tobj.name=name
    tobj.phone=phone
    tobj.email=email
    tobj.qualification=qualification
    tobj.specialization=specialization
    tobj.gender=gender
    tobj.dob=dob
    tobj.experience=experience
    tobj.save()

    return HttpResponse('''<script>alert('Successfully updated');window.location="/myapp/trainer_viewprofile/#id"</script>''')




def trainer_home(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request,'trainer/homeindex.html')



def trainer_viewprofile(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Trainer.objects.get(LOGIN_id=request.session['lid'])
    return render(request,"trainer/viewprofile.html",{"data":res})



def trainer_view_serviceplan(request):
    if request.session.get('lid') is None:
        return render(request, 'loginindex.html')

    # Fetch all service plans along with their features
    res = Serviceplan.objects.values(
        'id', 'Splan', 'amount', 'duration',
        'unlimited_equipment', 'personal_trainer',
        'weight_loss_classes', 'group_classes', 'nutrition_plan'
    )
    return render(request, "trainer/viewserviceplan.html", {"data": res})

def trainer_view_serviceplan_post(request):
    if request.session.get('lid') is None:
        return render(request, 'loginindex.html')

    search = request.POST.get('search', '')
    res = Serviceplan.objects.filter(Splan__icontains=search).values(
        'id', 'Splan', 'amount', 'duration',
        'unlimited_equipment', 'personal_trainer',
        'weight_loss_classes', 'group_classes', 'nutrition_plan'
    )
    return render(request, "trainer/viewserviceplan.html", {"data": res})


def trainer_manage_workoutplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    # res=Serviceplan.objects.all()
    return render(request,"trainer/manageworkoutplan.html",{"id":id})





def trainer_manage_workoutplan_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    workoutname=request.POST['select']
    description=request.POST['textarea']
    video=request.FILES['filefield']
    level=request.POST['textfield']
    reqid=request.POST['reqid']

    fs = FileSystemStorage()
    date = "workoutplan/"+datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".mp4"
    fn = fs.save(date,video)
    path = fs.url(date)

    wobj=Workoutvideos()
    wobj.workoutname=workoutname
    wobj.level=level
    wobj.REQUEST_id=reqid
    wobj.video=path
    wobj.description=description
    wobj.TRAINER=Trainer.objects.get(LOGIN=request.session['lid'])
    wobj.save()

    return HttpResponse(
        '''<script>alert('CREATED Succesfull');window.location="/myapp/trainer_home/"</script>''')

def trainer_view_workoutplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Workoutvideos.objects.filter(REQUEST_id=id)
    request.session['cid']=id

    return render(request,"trainer/viewtrainerworkout.html",{"data":res})

def trainer_view_workoutplan_POST(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    SEARCH=request.POST['textfield']
    res=Workoutvideos.objects.filter(workoutname__icontains=SEARCH,REQUEST_id=request.session['cid'])
    return render(request,"trainer/viewtrainerworkout.html",{"data":res})


def delete_workoutplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Workoutvideos.objects.filter(id=id).delete()
    return HttpResponse('''<script>alert('Delete Successfull');window.location="/myapp/trainer_view_workoutplan/"</script>''')



def trainer_editworkoutplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Workoutvideos.objects.get(id=id)
    return render(request,"trainer/editworkoutplan.html",{"data":res})

def trainer_edit_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    workname=request.POST['select']
    level=request.POST['textfield']
    description=request.POST['textarea']
    wid=request.POST['wid']
    wobj = Workoutvideos.objects.get(id=wid)

    if 'filefield' in request.FILES:

        video = request.FILES['filefield']
        fs = FileSystemStorage()
        date = "workoutplan/"+datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".mp4"
        fn = fs.save(date,video)
        path = fs.url(date)
        wobj.video = path
        wobj.save()

    wobj.workoutname=workname
    wobj.level=level
    wobj.description=description
    wobj.TRAINER=Trainer.objects.get(LOGIN=request.session['lid'])
    wobj.save()
    return HttpResponse(
        '''<script>alert('Updated Succesfull');window.location="/myapp/trainer_viewapprovedrequest/"</script>''')





def trainer_manage_classplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    request.session['cid']=id

    return render(request,"trainer/manageclassplan.html",{"id":id})


def trainer_manage_classplan_post(request):
     if request.session['lid'] == '':
        return render(request, 'loginindex.html')
     dateadd=request.POST['date']
     time=request.POST['time']
     classname=request.POST['select']
     description=request.POST['textarea']
     video=request.FILES['filefield']
     pid=request.POST['reqid']
     request.session['pid']=pid

     fs = FileSystemStorage()
     date = "classplan/" + datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".mp4"
     fn = fs.save(date, video)
     path = fs.url(date)

     dobj=Classes()
     dobj.date=dateadd
     dobj.time=time
     dobj.classname=classname
     dobj.description=description
     dobj.video=path
     dobj.REQUEST_id=pid
     dobj.save()

     pid=request.session['cid']

     return HttpResponse(
         f'''<script>alert('Added Succesfull');window.location="/myapp/trainer_viewapprovedrequest/#id"</script>''')





def trainer_viewclassplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Classes.objects.filter(REQUEST__id=id)
    return render(request, "trainer/viewclassplan.html",{"data":res})










def trainer_manage_dietplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request,"trainer/managedietplan.html",{"id":id})


def trainer_manage_dietplan_post(request):
     if request.session['lid'] == '':
        return render(request, 'loginindex.html')
     Days=request.POST['select']
     Session=request.POST['textfield']
     Diets=request.POST['textfield2']
     pid=request.POST['pid']
     request.session['pid']=pid

     dobj=Dietplan()
     dobj.Days=Days
     dobj.Session=Session
     dobj.diets=Diets
     dobj.WORKOUTPLAN_id=pid
     dobj.save()

     pid=request.session['cid']

     return HttpResponse(
         f'''<script>alert('Added Succesfull');window.location="/myapp/trainer_view_workoutplan/{pid}#id"</script>''')


def trainer_editdietplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res = Dietplan.objects.get(id=id)
    return render(request, "trainer/editdietplan.html",{"data":res})

def trainer_editdietplan_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Days=request.POST['select']
    Session=request.POST['textfield']
    Diets=request.POST['textfield2']
    id=request.POST['id']

    dobj = Dietplan.objects.get(id=id)
    dobj.Days = Days
    dobj.Session = Session
    dobj.diets = Diets
    dobj.WORKOUTPLAN_id = request.session['pid']
    dobj.save()

    return HttpResponse(
        '''<script>alert('Update Succesfull');window.location="/myapp/trainer_viewapprovedrequest/"</script>''')


def trainer_viewdietplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Dietplan.objects.filter(WORKOUTPLAN__id=id)
    return render(request, "trainer/viewdietplan.html",{"data":res})



def delete_dietplan(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Dietplan.objects.filter(id=id).delete()
    return HttpResponse('''<script>alert('Delete Successfull');window.location="/myapp/trainer_view_workoutplan/"</script>''')




def trainer_manage_tips(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request, "trainer/managetips.html",{'id':id})

def trainer_manage_tips_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Tip=request.POST['textfield']
    desc=request.POST['desc']
    category=request.POST['cat']
    id=request.POST['id']
    tobj=Tips()
    tobj.tips=Tip
    tobj.description=desc
    tobj.category=category
    tobj.REQUEST_id=id
    tobj.save()

    return HttpResponse(
        '''<script>alert('added Successfull');window.location="/myapp/trainer_viewapprovedrequest/#id"</script>''')

def trainer_viewtips(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res = Tips.objects.filter(REQUEST_id=id)
    print(res)
    request.session['rid']=id
    return render(request,"trainer/viewtips.html",{"data":res})


def trainer_viewtips_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    search = request.POST['search']
    res = Tips.objects.filter(REQUEST_id=request.session['rid'],tips__icontains=search)
    print(res)
    return render(request,"trainer/viewtips.html",{"data":res})



def trainer_edittips(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Tips.objects.get(id=id)
    return render(request,"trainer/edittips.html",{"data":res})



def trainer_edittips_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Tip=request.POST['textfield']
    cat=request.POST['cat']
    desc=request.POST['desc']
    tid=request.POST['tid']
    tobj=Tips.objects.get(id=tid)
    tobj.tips = Tip
    tobj.category=cat
    tobj.description=desc
    tobj.save()

    return HttpResponse(f'''<script>alert('Edited Successfull');window.location="/myapp/trainer_viewapprovedrequest/#id"</script>''')

def delete_tips(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Tips.objects.filter(id=id).delete()
    return HttpResponse('''<script>alert('Delete Successfull');window.location="/myapp/trainer_viewtips/"</script>''')



def trainer_viewrequestorapproverequest(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Request.objects.filter(TRAINER__LOGIN__id=request.session['lid'],status="pending")
    return render(request, "trainer/viewrequestorapproverequest.html",{"data":res})


def approve_userrequest(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Request.objects.filter(id=id).update(status="approved")
    request.session['rid']=id
    return HttpResponse('''<script>alert('Approved Successfull');window.location="/myapp/trainer_home/"</script>''')

def reject_userrequest(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Request.objects.filter(id=id).update(status="rejected")
    return HttpResponse('''<script>alert('rejected Successfull');window.location="/myapp/trainer_home/"</script>''')



def trainer_viewrequestorapproverequest_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    From=request.POST['textfield2']
    To=request.POST['button']

    res = Request.objects.filter(TRAINER__LOGIN__id=request.session['lid'], status="pending",date__range=[From,To])
    return render(request, "trainer/viewrequestorapproverequest.html", {"data": res})


def trainer_viewapprovedrequest(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Request.objects.filter(TRAINER__LOGIN__id=request.session['lid'],status="approved")
    return render(request, "trainer/viewapprovedreq.html",{"data":res})

def trainer_viewapprovedrequest_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    From = request.POST['textfield']
    to = request.POST['textfield2']
    res = Request.objects.filter(TRAINER__LOGIN__id=request.session['lid'], status="approved",date__range=[From,to])
    return render(request, "trainer/viewapprovedreq.html", {"data": res})


def trainer_viewrejectedreq(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res=Request.objects.filter(TRAINER__LOGIN__id=request.session['lid'],status="rejected")
    return render(request, "trainer/viewrejectedreq.html",{"data":res})

def trainer_viewrejectedreq_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    From = request.POST['textfield']
    to = request.POST['textfield2']
    res = Request.objects.filter(TRAINER__LOGIN__id=request.session['lid'], status="rejected",date__range=[From,to])
    return render(request, "trainer/viewrejectedreq.html", {"data": res})


def trainer_changepassword(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request, "trainer/changepassword.html")

def trainer_changepassword_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    currentpassword=request.POST['textfield']
    newpassword=request.POST['textfield2']
    confirmpassword=request.POST['textfield3']
    res=Login.objects.filter(id=request.session['lid'],password=currentpassword)
    if res.exists():
        if newpassword==confirmpassword:
            res = Login.objects.filter(id=request.session['lid'], password=currentpassword).update(password=confirmpassword)
            return HttpResponse(
                '''<script>alert('Changed Successfully');window.location="/myapp/login/"</script>''')
        else:
            return HttpResponse(
                '''<script>alert('password mismatched');window.location="/myapp/trainer_changepassword/"</script>''')
    else:
        return HttpResponse(
            '''<script>alert('Invalid');window.location="/myapp/trainer_changepassword/"</script>''')

def trainer_viewfacilityget(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res = Facility.objects.all()
    return render(request, 'trainer/viewfacility.html', {"data": res})

def trainer_viewfacilitypost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    search = request.POST['search']
    res = Facility.objects.filter(equipment_name__icontains=search)
    return render(request, 'trainer/viewfacility.html', {"data": res})


# def view_user_payment(request,id):
#
#     re=Request.objects.filter(USER_id=id)
#     res=Payment.objects.filter(USER_id=re)
#     return render(request,'trainer/viewpayment.html',{'data':res})


def trainer_viewprogresst(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res = Progress.objects.filter(WORKOUTPLAN_id=id)
    return render(request, 'trainer/viewprogress.html', {"data": res})


def add_schedule(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    return render(request,'trainer/addschedule.html')

def add_schedule_post(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    date=request.POST['textfield']
    fromtime=request.POST['textfield2']
    totime=request.POST['textfield3']
    res=Schedule()
    res.fromtime=fromtime
    res.totime=totime
    res.date=date
    res.status='available'
    res.TRAINER=Trainer.objects.get(LOGIN=request.session['lid'])
    res.save()
    return HttpResponse(
            '''<script>alert('success');window.location="/myapp/add_schedule/"</script>''')






def trainer_viewschedule(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    res = Schedule.objects.filter(TRAINER__LOGIN_id=request.session['lid'])
    return render(request, 'trainer/viewschedule.html', {"data": res})

def trainer_viewschedulepost(request):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    fromdate = request.POST['from']
    todate = request.POST['to']
    res = Schedule.objects.filter(TRAINER__LOGIN_id=request.session['lid'],date__range=[fromdate,todate])
    return render(request, 'trainer/viewschedule.html', {"data": res})



def delete_schedule(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Schedule.objects.get(id=id).delete()
    return HttpResponse(
            '''<script>alert('Deleted');window.location="/myapp/trainer_viewschedule/#id"</script>''')



def delete_class(request,id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    Classes.objects.get(id=id).delete()
    sid=request.session['rid']
    return HttpResponse(
            f'''<script>alert('Deleted');window.location="/myapp/trainer_viewapprovedrequest/#id"</script>''')





from django.shortcuts import render
from .models import Request, Payment


def view_user_payment(request, id):
    if request.session['lid'] == '':
        return render(request, 'loginindex.html')
    # Get the request associated with the user (USER_id)
    user_request = Request.objects.filter(USER_id=id)

    # Check if there is a valid request associated with the user
    if user_request.exists():
        # Get the payments associated with the same USER_id
        payments = Payment.objects.filter(USER_id=id)

        # Return the payments in the template context
        return render(request, 'trainer/viewpayment.html', {'data': payments})
    else:
        # No request found for this user, handle the error (optional)
        return render(request, 'trainer/viewpayment.html', {'message': 'No request found for this user.'})


def and_forget_password_post(request):

    email = request.POST['em_add']
    res = Login.objects.filter(username=email)
    if res.exists():
        import random
        new_pass = random.randint(0000, 9999)
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login("safedore3@gmail.com", "yqqlwlyqbfjtewam")  # App Password
        to = email
        subject = "Test Email"
        body = "Your new password is " + str(new_pass)
        msg = f"Subject: {subject}\n\n{body}"
        server.sendmail("s@gmail.com", to, msg)        # Disconnect from the server
        server.quit()
        ress = Login.objects.filter(username=email).update(password=new_pass)
        return JsonResponse({'status':'ok'})
    else:
        return JsonResponse({'status':'ok'})





####################




def chat1(request,id):
    request.session["userid"] = id
    cid = str(request.session["userid"])
    request.session["new"] = cid
    qry = User.objects.get(LOGIN=cid)

    return render(request, "trainer/Chat.html", {'photo': qry.photo, 'name': qry.name, 'toid': cid})

def chat_view(request):
    fromid = request.session["lid"]
    toid = request.session["userid"]
    qry = User.objects.get(LOGIN=request.session["userid"])
    from django.db.models import Q

    res = Chat.objects.filter(Q(FROMID_id=fromid, TOID_id=toid) | Q(FROMID_id=toid, TOID_id=fromid))
    l = []

    for i in res:
        l.append({"id": i.id, "message": i.message, "to": i.TOID_id, "date": i.date, "from": i.FROMID_id})

    return JsonResponse({'photo': qry.photo, "data": l, 'name': qry.name, 'toid': request.session["userid"]})

def chat_send(request, msg):
    lid = request.session["lid"]
    toid = request.session["userid"]
    message = msg

    import datetime
    d = datetime.datetime.now().date()
    chatobt = Chat()
    chatobt.message = message
    chatobt.TOID_id = toid
    chatobt.FROMID_id = lid
    chatobt.date = d
    chatobt.save()

    return JsonResponse({"status": "ok"})




def User_sendchat(request):
    FROM_id=request.POST['from_id']
    TOID_id=request.POST['to_id']
    print(FROM_id)
    print(TOID_id)
    msg=request.POST['message']

    from  datetime import datetime
    c=Chat()
    c.FROMID_id=FROM_id
    c.TOID_id=TOID_id
    c.message=msg
    c.date=datetime.now()
    c.save()
    return JsonResponse({'status':"ok"})


def User_viewchat(request):
    fromid = request.POST["from_id"]
    toid = request.POST["to_id"]
    # lmid = request.POST["lastmsgid"]
    from django.db.models import Q

    res = Chat.objects.filter(Q(FROMID_id=fromid, TOID_id=toid) | Q(FROMID_id=toid, TOID_id=fromid))
    l = []

    for i in res:
        l.append({"id": i.id, "msg": i.message, "from": i.FROMID_id, "date": i.date, "to": i.TOID_id})

    return JsonResponse({"status":"ok",'data':l})
















#############






def login(request):
    name=request.POST['name']
    password=request.POST['password']
    l=Login.objects.filter(username=name,password=password)
    if l.exists():
        log=Login.objects.get(username=name,password=password)
        lid=log.id
        if log.type=="user":
            i = User.objects.get(LOGIN_id = lid)
            return JsonResponse({'status':'ok',"lid":str(lid),"name":i.name,"photo":i.photo})
        else:
            return JsonResponse({'status':'no'})
    else:
        return JsonResponse({'status': 'no'})


def viewprofile(request):
    id=request.POST['lid']
    v=User.objects.get(LOGIN_id=id)

    return JsonResponse({'status':'ok',
                         'name':v.name,
                         'email':v.email,
                         'phoneno':v.phoneno,
                         'place':v.place,
                         'pin':v.pin,
                         'post':v.post,
                         'district':v.district,
                         'photo':v.photo,'gender':v.gender})

def editprofile(request):
    name = request.POST['name']
    place = request.POST['place']
    email = request.POST['email']
    phoneno = request.POST['phoneno']
    post= request.POST['post']
    pin= request.POST['pin']
    district= request.POST['district']
    photo= request.POST['photo']
    gender= request.POST['gender']
    lid=request.POST['lid']


    if len(photo)>0:

        import base64
        date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
        abc = base64.b64decode(photo)
        fs = open("E:\\GYMGUIDE\\media\\user\\" + date, "wb")
        photopath = '/media/user/' + date
        fs.write(abc)
        fs.close()

        uobj = User.objects.get(LOGIN__id=lid)
        uobj.name = name
        uobj.email = email
        uobj.phoneno = phoneno
        uobj.place = place
        uobj.post = post
        uobj.pin = pin
        uobj.disrict = district
        uobj.photo = photopath
        uobj.gender = gender
        uobj.save()

    uobj = User.objects.get(LOGIN__id=lid)
    uobj.name = name
    uobj.email = email
    uobj.phoneno = phoneno
    uobj.place = place
    uobj.post = post
    uobj.pin = pin
    uobj.disrict = district
    uobj.gender = gender
    uobj.save()
    return JsonResponse({'status':'ok'})


def signup(request):
    name = request.POST['name']
    place = request.POST['place']
    email = request.POST['email']
    phoneno = request.POST['phoneno']
    post= request.POST['post']
    pin= request.POST['pin']
    medical= request.FILES['medical']
    dob= request.POST['dob']
    weight= request.POST['weight']
    height= request.POST['height']
    district= request.POST['district']
    photo= request.POST['photo']
    gender= request.POST['gender']
    password= request.POST['password']
    confirm_password= request.POST['confirmpassword']

    import base64
    date=datetime.datetime.now().strftime("%Y%m%d%H%M%S")+".jpg"
    abc=base64.b64decode(photo)
    fs=open("E:\\GYMGUIDE\\media\\user\\"+date,"wb")
    photopath='/media/user/'+date
    fs.write(abc)
    fs.close()

    fs2 = FileSystemStorage()
    date2 = "certificate/" + datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".pdf"
    fn = fs2.save(date2, medical)
    path2 = fs2.url(date2)



    lobj=Login()
    lobj.username=email
    lobj.password=confirm_password
    lobj.type="user"
    lobj.save()


    uobj=User()
    uobj.name=name
    uobj.email=email
    uobj.phoneno=phoneno
    uobj.place=place
    uobj.post=post
    uobj.pin=pin
    uobj.district=district
    uobj.dob=dob
    uobj.height=height
    uobj.weight=weight
    uobj.weightmedicaldetails=path2
    uobj.photo=photopath
    uobj.gender=gender
    uobj.LOGIN=lobj
    uobj.save()
    return JsonResponse({'status':'ok'})

def viewtrainers(request):
    res=Trainer.objects.filter(status='approved')
    l=[]
    for i in res:
        l.append({"id":i.id,
                  "name":i.name,
                  "phone":i.phone,
                  "email":i.email,
                  "qualification":i.qualification,
                  "gender":i.gender,
                  'specialization':i.specialization,
                  "age":i.dob,
                  "photo":i.photo,
                  "experience":i.experience})
    return JsonResponse({'status':'ok',"data":l})



def user_view_req_status(request):
    lid = request.POST['lid']
    print(lid)
    p = Request.objects.filter(USER__LOGIN_id=lid)
    l=[]
    for i in p:
        l.append({"id":i.id,
                  "name":i.TRAINER.name,
                  "phone":i.TRAINER.phone,
                  "mail":i.TRAINER.email,
                  "tid":i.TRAINER.LOGIN.id,
                  "date":i.date,
                  "status":i.status,
                  "photo":i.TRAINER.photo
                  })
    return JsonResponse({"status":"ok","data":l})


#
#
# def trainer_chat_send(request):
#     msg=request.POST['msg']
#     FROM_id=request.POST['lid']
#     TOID_id=request.POST['tid']
#     print(TOID_id,'--toid--',FROM_id,'--fid--')
#
#
#     c=Chat()
#     c.FROM_id=FROM_id
#     c.TO_id=TOID_id
#     c.message=msg
#     c.date=datetime.now().date()
#     # c.time=datetime.now().time()
#     c.save()
#     return JsonResponse({'status':"ok"})
#
# def trainer_chat_view(request):
#     from_id=request.POST['lid']
#     to_id=request.POST['tid']
#     l=[]
#
#     data1=Chat.objects.filter(FROM_id=from_id,TO_id=to_id).order_by('id')
#     data2=Chat.objects.filter(FROM_id=to_id,TO_id=from_id).order_by('id')
#
#     data= data1 | data2
#     print(data)
#
#     for res in data:
#         l.append({'id':res.id,
#                   'from':res.FROM.id,
#                   'to':res.TO.id,
#                   'msg':res.message,
#                   'date':res.date})
#
#     u=Trainer.objects.get(LOGIN_id=to_id)
#     return JsonResponse({'status':"ok",
#                          'data':l,
#                          "name":u.name,
#                          "photo":u.photo,
#                          "toid":to_id})




def sendcomplaint(request):

    lid = request.POST['lid']
    comp = request.POST['about']

    om = Complaint()
    d = datetime.datetime.now().today()
    om.date = d
    om.status = 'pending'
    om.reply = 'pending'
    om.USER = User.objects.get(LOGIN_id=lid)
    om.complaint = comp
    om.save()

    return JsonResponse({'status':'ok'})


def sendreview(request):

    lid = request.POST['lid']
    review = request.POST['about']
    rating = request.POST['rating']
    tid = request.POST['tid']

    om = Review()
    d = datetime.datetime.now().today()
    om.rating=rating
    om.date = d
    om.USER = User.objects.get(LOGIN_id=lid)
    om.review = review
    om.TRAINER_id=tid
    om.save()

    return JsonResponse({'status':'ok'})




def viewreply(request):
    lid = request.POST['lid']
    res=Complaint.objects.filter(USER__LOGIN_id = lid)
    l=[]
    for i in res:
        l.append({"id":i.id,
                  "date":i.date,
                  'status':i.status,
                  "complaint":i.complaint,
                  "reply":i.reply,
                  })
        print(l)
    return JsonResponse({'status':'ok',"data":l})

def sendtrainerrequest(request):

    lid = request.POST['lid']
    tid = request.POST['tid']


    if Request.objects.filter(USER__LOGIN_id=lid,TRAINER_id = tid).exists():
        return JsonResponse({'status': 'no'})

    om = Request()
    d = datetime.datetime.now().today()
    om.date = d
    om.status = 'pending'
    om.USER = User.objects.get(LOGIN_id=lid)
    om.TRAINER_id = tid
    om.save()

    return JsonResponse({'status':'ok'})

# def viewserviceplan(request):
#
#     lid=request.POST['lid']
#     res=Serviceplan.objects.all()
#     l=[]
#     for i in res:
#         pp = Payment.objects.get(USER__LOGIN_id=lid,SERVICEPLAN_id=i.id)
#
#         l.append({"id":i.id,
#                   "plan":i.Splan,
#                   "dur":i.duration,
#                   "amnt":i.amount,
#                   'sts':pp.status
#                   })
#         print(l)
#     return JsonResponse({'status':'ok',"data":l})


def viewserviceplan(request):
    lid = request.POST.get('lid')  # Use get() to avoid KeyError if 'lid' is missing
    res = Serviceplan.objects.all()
    l = []

    for i in res:
        pp = Payment.objects.filter(USER__LOGIN_id=lid,
                                    SERVICEPLAN_id=i.id).first()  # Use filter().first() to avoid exception
        l.append({
            "id": i.id,
            "plan": i.Splan,
            "dur": i.duration,
            "amnt": i.amount,
            'sts': pp.status if pp else "No Payment Found"  # Handle missing payment
        })

    return JsonResponse({'status': 'ok', "data": l})


def viewworkoutplan(request):
    sid = request.POST['sid']
    res=Workoutvideos.objects.filter(SERVICEPLAN=sid)
    l=[]
    for i in res:
        l.append({"id":i.id,
                  "plan":i.plan,
                  "photo":i.photo,
                  "description":i.description})
    return JsonResponse({'status':'ok',"data":l})

def viewdietplan(request):
    wid = request.POST['wid']
    res =Dietplan.objects.filter(WORKOUTPLAN=wid)
    l = []
    for i in res:
        l.append({"day":i.Days,"session":i.Session,"diets":i.diets})
    return JsonResponse({'status':'ok',"data":l})

def viewtips(request):
    lid=request.POST['lid']
    res =Tips.objects.filter(REQUEST__USER__LOGIN_id=lid)
    l = []
    for i in res:
        l.append({"id":i.id,
                  "tips":i.tips,
                  "category":i.category,
                  "description":i.description,
                  "trainer":i.REQUEST.TRAINER.name,
                  })


    return JsonResponse({'status':'ok',"data":l})

def chatwithuser(request):
    res = Chat.objects.all()
    l = []
    for i in res:
        l.append({"frontid":i.frontid,"toid":i.toid,"message":i.message,"date":i.date})

    return JsonResponse({'status':'ok',"data":l})

def viewmotivationalvideos(request):

    res =Motivationalvideo.objects.all()
    l = []
    for i in res:
        l.append({"id":i.id,
                  "title":i.title,
                  "vid":i.video,
                  "trainer":i.TRAINER.name,
                  "about":i.description,
                  })

    return JsonResponse({'status':'ok',"data":l})

def viewworkoutvideo(request):
    lid=request.POST['lid']
    res = Workoutvideos.objects.filter(REQUEST__USER__LOGIN_id=lid)
    l = []
    for i in res:
        l.append({
            "id":i.id,
            "workoutname":i.workoutname,
            "video":i.video,
            "description":i.description,
            "level":i.level,


        })
    return JsonResponse({'status':'ok',"data":l})



def viewprogress(request):
    lid=request.POST['lid']
    res = Progress.objects.filter(USER__LOGIN_id=lid)
    l = []
    for i in res:
        l.append({
            "id":i.id,
            "date":i.date,
            "caloriesburned":i.caloriesburned,
            "progressnotes":i.progressnotes,
            "weight":i.weight,
            "workout":i.WORKOUTPLAN.workoutname,


        })
    return JsonResponse({'status':'ok',"data":l})
def tracktheirprogress(request):
    abt = request.POST['about']
    cal = request.POST['calories']
    wt = request.POST['weight']
    date = request.POST['date']
    lid = request.POST['lid']
    wid = request.POST['wid']

    res = Progress()
    res.progressnotes = abt
    res.date = date
    res.USER = User.objects.get(LOGIN_id = lid)
    res.weight=wt
    res.caloriesburned=cal
    res.WORKOUTPLAN_id=wid
    res.save()

    return JsonResponse({'status':'ok'})


def user_change_pass(request):
    old = request.POST['op']
    print(old)
    new = request.POST['np']
    print(new)
    cnew = request.POST['cp']
    print(cnew)
    id = request.POST['lid']
    print(id,'---------------------------')

    l = Login.objects.get(id=id)
    if l.password == old:
        print(l.password)
        if new == cnew:
            Login.objects.filter(id=id).update(password=cnew)
            return JsonResponse({"status":"ok"})
        else:
            return JsonResponse({"status":"no"})
    else:
        return JsonResponse({"status":"no"})




def viewreviewfromuser(request):
    tid=request.POST['tid']
    res=Review.objects.filter(TRAINER_id=tid)
    l=[]
    for i in res:
        l.append({"id":i.id,
                  "date":i.date,
                  "review":i.review,
                  "rating":i.rating,
                  "user":i.USER.name
                  })
        print(l)
    return JsonResponse({'status':'ok',"data":l})















###########################3




def Add_health_profile(request):
    lid = request.POST['lid']
    Height = request.POST['Height']
    Weight = request.POST['Weight']
    Age = request.POST['Age']
    # Gender = request.POST['Gender']
    Obicity = request.POST['Obicity']
    Bloodpressure = request.POST['Bloodpressure']
    Diabetes = request.POST['Diabetes']
    Cholestrol = request.POST['Cholestrol']
    Alcoholabuse = request.POST['Alcoholabuse']
    Druguse = request.POST['Druguse']
    Smoking = request.POST['Smoking']
    Headaches = request.POST['Headaches']
    Asthma = request.POST['Asthma']
    Heartproblem = request.POST['Heartproblem']
    Cancer = request.POST['Cancer']
    Stroke = request.POST['Stroke']
    Bone_joint = request.POST['Bone_joint']
    Kidney = request.POST['Kidney']
    Liver = request.POST['Liver']
    Depression = request.POST['Depression']
    Allergies = request.POST['Allergies']
    Arthritis = request.POST['Arthritis']
    Pregnancy = request.POST['Pregnancy']
    print(type(Height))
    bmi=float(Weight)/(float(Height)*float(Height))
    # bmi = request.POST['bmi']
    # Bloodgroup = request.POST['Bloodgroup']
    # Bodytype = request.POST['Bodytype']



    Pobj=Health_profle()
    Pobj.Height=Height
    Pobj.Weight=Weight
    Pobj.Age=Age
    # Pobj.Gender = Gender
    Pobj.Obicity = Obicity
    Pobj.Bloodpressure = Bloodpressure
    Pobj.Diabetes = Diabetes
    Pobj.Cholestrol = Cholestrol
    Pobj.Alcoholabuse = Alcoholabuse
    Pobj.Druguse = Druguse
    Pobj.Smoking = Smoking
    Pobj.Headaches = Headaches
    Pobj.Asthma = Asthma
    Pobj.Heartproblem = Heartproblem
    Pobj.Cancer = Cancer
    Pobj.Stroke = Stroke
    Pobj.Bone_joint = Bone_joint
    Pobj.Kidney = Kidney
    Pobj.Liver = Liver
    Pobj.Depression = Depression
    Pobj.Allergies = Allergies
    Pobj.Arthritis = Arthritis
    Pobj.Pregnancy = Pregnancy
    Pobj.bmi = bmi*10000
    # Pobj.Bloodgroup=Bloodgroup
    # Pobj.Bodytype=Bodytype
    Pobj.USER=User.objects.get(LOGIN_id=lid)
    Pobj.save()
    return JsonResponse({'status':'ok'})


def Edit_health_profile(request):
    lid = request.POST['lid']
    print(lid)
    Height = request.POST['Height']
    Weight = request.POST['Weight']
    Age = request.POST['Age']
    # Gender = request.POST['Gender']
    Obicity = request.POST['Obicity']
    Bloodpressure = request.POST['Bloodpressure']
    Diabetes = request.POST['Diabetes']
    Cholestrol = request.POST['Cholestrol']
    Alcoholabuse = request.POST['Alcoholabuse']
    Druguse = request.POST['Druguse']
    Smoking = request.POST['Smoking']
    Headaches = request.POST['Headaches']
    Asthma = request.POST['Asthma']
    Heartproblem = request.POST['Heartproblem']
    Cancer = request.POST['Cancer']
    Stroke = request.POST['Stroke']
    Bone_joint = request.POST['Bone_joint']
    Kidney = request.POST['Kidney']
    Liver = request.POST['Liver']
    Depression = request.POST['Depression']
    Allergies = request.POST['Allergies']
    Arthritis = request.POST['Arthritis']
    Pregnancy = request.POST['Pregnancy']
    print(type(Height))
    bmi = float(Weight) / (float(Height) * float(Height))
    # bmi = request.POST['bmi']
    # Bloodgroup = request.POST['Bloodgroup']
    # Bodytype = request.POST['Bodytype']



    Pobj = Health_profle.objects.get(USER__LOGIN_id=lid)
    Pobj.Height = Height
    Pobj.Weight = Weight
    Pobj.Age = Age
    # Pobj.Gender = Gender
    Pobj.Obicity = Obicity
    Pobj.Bloodpressure = Bloodpressure
    Pobj.Diabetes = Diabetes
    Pobj.Cholestrol = Cholestrol
    Pobj.Alcoholabuse = Alcoholabuse
    Pobj.Druguse = Druguse
    Pobj.Smoking = Smoking
    Pobj.Headaches = Headaches
    Pobj.Asthma = Asthma
    Pobj.Heartproblem = Heartproblem
    Pobj.Cancer = Cancer
    Pobj.Stroke = Stroke
    Pobj.Bone_joint = Bone_joint
    Pobj.Kidney = Kidney
    Pobj.Liver = Liver
    Pobj.Depression = Depression
    Pobj.Allergies = Allergies
    Pobj.Arthritis = Arthritis
    Pobj.Pregnancy = Pregnancy
    Pobj.bmi = bmi * 10000
    # Pobj.Bloodgroup=Bloodgroup
    # Pobj.Bodytype=Bodytype
    Pobj.save()
    return JsonResponse({'status':'ok'})


def Delete_health_profile(request):
    lid = request.POST['lid']
    t=Health_profle.objects.get(id=lid).delete()
    return JsonResponse({'status':'ok'})


def View_health_profile(request):
    lid = request.POST['lid']
    u = Health_profle.objects.get(USER__LOGIN_id=lid)
    return JsonResponse(
        {'status': 'ok', 'Height': u.Height, 'Weight': u.Weight, 'Age': u.Age,
         # 'Gender': u.Gender,
         'Obicity': u.Obicity
            , 'Bloodpressure': u.Bloodpressure, 'Diabetes': u.Diabetes, 'Cholestrol': u.Cholestrol, 'Alcoholabuse': u.Alcoholabuse
            , 'Druguse': u.Druguse, 'Smoking': u.Smoking, 'Headaches': u.Headaches, 'Asthma': u.Asthma
            , 'Heartproblem': u.Heartproblem, 'Cancer': u.Cancer, 'Stroke': u.Stroke, 'Bone_joint': u.Bone_joint
            , 'Kidney': u.Kidney, 'Liver': u.Liver, 'Depression': u.Depression, 'Allergies': u.Allergies, 'Arthritis': u.Arthritis, 'Pregnancy': u.Pregnancy
            , 'bmi': u.bmi
            # , 'Bloodgroup': u.Bloodgroup, 'Bodytype': u.Bodytype
         })









def Get_health_pr(request):
    lid = request.POST['lid']


    d=Diet_chart.objects.all()

    if not Health_profle.objects.filter(USER__LOGIN_id=lid).exists():

        return JsonResponse({'status': 'no'})
    else:



        h=Health_profle.objects.get(USER__LOGIN_id=lid)

        features=[]
        label=[]




        test=[]


        obicity=0
        gender=0
        boodpressuree=0
        diabetes=0
        cholestrol=0
        alcoholabuse=0
        druguse=0
        smoking=0
        headaches=0
        asthma=0
        heartproblem=0
        cancer=0
        stroke=0
        kidney=0
        liver=0
        depression=0
        allergies=0
        arthritis=0
        pregnancy=0









        if  h.Obicity== "Normal":
            obicity=0
        elif h.Obicity=="OverWeight":
            obicity=1
        elif  h.Obicity=="Obesity":
            obicity=2




        if h.USER.gender=="Male":
            gender=0
        elif h.USER.gender=="Female":
            gender=1




        if h.Bloodpressure=="Low":
            boodpressuree=0
        elif h.Bloodpressure=="Normal":
            boodpressuree=1
        elif h.Bloodpressure=="High":
            boodpressuree=2




        if h.Diabetes=="Low":
            diabetes=0
        elif h.Diabetes=="Normal":
            diabetes=1
        elif h.Diabetes=="High":
            diabetes=2




        if h.Cholestrol=="low-density lipoprotein (LDL)":
            cholestrol=0
        elif h.Cholestrol=="high-density lipoprotein (HDL)":
            cholestrol=1
        elif h.Cholestrol=="Lipoprotein(a) Cholesterol":
            cholestrol=2




        if h.Alcoholabuse=="Light or social drinkers":
            alcoholabuse=0
        elif h.Alcoholabuse=="Moderate drinker":
            alcoholabuse=1
        elif h.Alcoholabuse=="Heavy drinkers":
            alcoholabuse=2
        elif h.Alcoholabuse=="No Use":
            alcoholabuse=3




        if h.Druguse=="stimulants":
            druguse=0
        elif h.Druguse=="narcotics":
            druguse=1
        elif h.Druguse=="sedatives":
            druguse=2
        elif h.Druguse=="No":
            druguse=3


        if h.Smoking=="No":
            smoking=0
        elif h.Smoking=="Yes":
            smoking=1




        if h.Headaches=="No":
            headaches=0
        elif h.Headaches=="Yes":
            headaches=1



        if h.Asthma=="No":
            asthma=0
        elif h.Asthma=="Yes":
            asthma=1



        if h.Heartproblem=="No":
            heartproblem=0
        elif h.Heartproblem=="Yes":
            heartproblem=1




        if h.Cancer=="No":
            cancer=0
        elif h.Cancer=="Yes":
            cancer=1



        if h.Stroke=="No":
            stroke=0
        elif h.Stroke=="Yes":
            stroke=1


        if h.Kidney=="No":
            kidney=0
        elif h.Kidney=="Yes":
            kidney=1


        if h.Liver=="No":
            liver=0
        elif h.Liver=="Yes":
            liver=1


        if h.Depression=="No":
            depression=0
        elif h.Depression=="Yes":
            depression=1


        if h.Allergies=="No":
            allergies=0
        elif h.Allergies=="Yes":
            allergies=1


        if h.Arthritis=="No":
            arthritis=0
        elif h.Arthritis=="Yes":
            arthritis=1


        if h.Pregnancy=="No":
            pregnancy=0
        elif h.Pregnancy=="Yes":
            pregnancy=1








        test=[
            gender,
            obicity,
            boodpressuree,
            diabetes,
            cholestrol,
            alcoholabuse,
            druguse,
            smoking,
            headaches,
            asthma,
            heartproblem,
            cancer,
            stroke,
            kidney,
            liver,
            depression,
            allergies,
            arthritis,
            pregnancy,
            h.bmi,

        ]





        for i in d:

            label.append(i.id)


            if i.Gender=="Male":
                gender=0
            elif i.Gender=="Female":
                gender = 1


            if i.Obicity=="Normal":
                obicity=0
            elif i.Obicity=="OverWeight":
                obicity = 1
            elif i.Obicity=="Obesity":
                obicity = 2


            if i.Bloodpressure=="Low":
                boodpressuree=0
            elif i.Bloodpressure=="Normal":
                boodpressuree = 1
            elif i.Bloodpressure=="High":
                boodpressuree = 2


            if i.Diabetes=="Low":
                diabetes=0
            elif i.Diabetes=="Normal":
                diabetes = 1
            elif i.Diabetes=="High":
                diabetes = 2


            if i.Cholestrol=="low-density lipoprotein (LDL)":
                cholestrol=0
            elif i.Cholestrol=="high-density lipoprotein (HDL)":
                cholestrol = 1
            elif i.Cholestrol=="Lipoprotein(a) Cholesterol":
                cholestrol = 2



            if i.Alcoholabuse=="Light or social drinkers":
                alcoholabuse=0
            elif i.Alcoholabuse=="Moderate drinker":
                alcoholabuse = 1
            elif i.Alcoholabuse=="Heavy drinkers":
                alcoholabuse = 2
            elif i.Alcoholabuse == "No Use":
                alcoholabuse = 3


            if i.Druguse=="stimulants":
                druguse=0
            elif i.Druguse=="narcotics":
                druguse = 1
            elif i.Druguse=="Heavy drinkers":
                druguse = 2
            elif i.Druguse == "No Use":
                druguse = 3


            if i.Smoking=="No":
                smoking=0
            elif i.Smoking=="Yes":
                smoking = 1


            if i.Headaches=="No":
                headaches=0
            elif i.Headaches=="Yes":
                headaches = 1



            if i.Asthma=="No":
                asthma=0
            elif i.Asthma=="Yes":
                asthma = 1


            if i.Heartproblem=="No":
                heartproblem=0
            elif i.Heartproblem=="Yes":
                heartproblem = 1


            if i.Cancer=="No":
                cancer=0
            elif i.Cancer=="Yes":
                cancer = 1


            if i.Stroke=="No":
                stroke=0
            elif i.Stroke=="Yes":
                stroke = 1


            if i.Kidney=="No":
                kidney=0
            elif i.Kidney=="Yes":
                kidney = 1


            if i.Liver=="No":
                liver=0
            elif i.Liver=="Yes":
                liver = 1


            if i.Depression=="No":
                depression=0
            elif i.Depression=="Yes":
                depression = 1


            if i.Allergies=="No":
                allergies=0
            elif i.Allergies=="Yes":
                allergies = 1


            if i.Arthritis=="No":
                arthritis=0
            elif i.Arthritis=="Yes":
                arthritis = 1



            if i.Pregnancy=="No":
                pregnancy=0
            elif i.Allergies=="Yes":
                pregnancy = 1





            # bmi not given!





            features.append(
                [
                    gender,
                    obicity,
                    boodpressuree,
                    diabetes,
                    cholestrol,
                    alcoholabuse,
                    druguse,
                    smoking,
                    headaches,
                    asthma,
                    heartproblem,
                    cancer,
                    stroke,
                    kidney,
                    liver,
                    depression,
                    allergies,
                    arthritis,
                    pregnancy,
                    i.bmi,

                ]
            )




        from sklearn.ensemble import  RandomForestClassifier

        r=RandomForestClassifier()

        r.fit(features,label)

        # s=r.predict_proba([test])

        # s = r.predict_proba(np.array(test).reshape(1, -1))

        test = np.array(test).reshape(1, -1)
        s = r.predict_proba(test)

        print(s)

        s=s[0]

        ls=[]

        for i in range(0,len(s)):

            dietid=label[i]



            if s[i]>.2:    #change according to the BMI value to get tha diet chart to user

                ss=Diet_chart.objects.get(id=dietid)

                ls.append(
                    {
                        'id':ss.id,
                        'name':ss.Name,
                        'date':ss.Date,
                        'time':ss.Time,
                        'dietplan':ss.Dietplan

                    }
                )


        return JsonResponse({'status': 'ok','data':ls})










def viewtrainerschedule(request):
    tid=request.POST['tid']
    res = Schedule.objects.filter(TRAINER_id=tid)
    l = []
    for i in res:
        l.append({
            "id":i.id,
            "date":i.date,
            "fromtime":i.fromtime,
            "totime":i.totime,



        })
    return JsonResponse({'status':'ok',"data":l})


def viewgymfacility(request):
    res = Facility.objects.all()

    l = []
    for i in res:
        l.append({
            "id":i.id,
            "equipment_name":i.equipment_name,
            "maintanance_status":i.maintanance_status,
            "quantity":i.quantity,
            "photo":i.photo,



        })
    return JsonResponse({'status':'ok',"data":l})



def viewclassplan(request):
    lid=request.POST['lid']
    res = Classes.objects.filter(REQUEST__USER__LOGIN_id=lid)

    l = []
    for i in res:
        l.append({
            "id":i.id,
            "classname":i.classname,
            "video":i.video,
            "description":i.description,
            "date":i.date,
            "time":i.time,



        })
    return JsonResponse({'status':'ok',"data":l})





# def viewattendance(request):
#     cid=request.POST['lid']
#     res = Attendance.objects.filter(USER__LOGIN_id=cid)
#
#     l = []
#     for i in res:
#         l.append({
#             "id":i.id,
#             "checkintime":i.checkintime,
#             "checkouttime":i.checkouttime,
#             "status":i.status,
#             "date":i.date,
#             "classname":i.CLASS.classname,
#         })
#     return JsonResponse({'status':'ok',"data":l})
def viewattendance(request):
    cid = request.POST.get('lid')  # Use get() to avoid KeyError
    res = Attendance.objects.filter(USER__LOGIN_id=cid)

    l = []
    for i in res:
        classname = i.CLASS.classname if i.CLASS else "No Class Assigned"  # Handle missing class
        l.append({
            "id": i.id,
            "checkintime": i.checkintime,
            "checkouttime": i.checkouttime,
            "status": i.status,
            "date": i.date,
            "classname": classname,
        })
    return JsonResponse({'status': 'ok', "data": l})



def user_payment(request):
    sid=request.POST['sid']
    lid=request.POST['lid']
    user=User.objects.get(LOGIN=lid)
    date=datetime.datetime.now().today()
    status='paid'
    payment_methos='online'
    amount=request.POST['amount']

    if Payment.objects.filter(SERVICEPLAN_id=sid,USER=user).exists():
        return JsonResponse({'status':'no'})
    obj=Payment()
    obj.SERVICEPLAN_id=sid
    obj.USER=user
    obj.payment_method=payment_methos
    obj.amount=amount
    obj.status=status
    obj.date=date
    obj.save()
    return JsonResponse({'status':'ok'})



#
# from django.http import HttpResponse
# from reportlab.pdfgen import canvas
#
# def download_report(request):
#     response = HttpResponse(content_type='application/pdf')
#     response['Content-Disposition'] = 'attachment; filename="report.pdf"'
#
#     p = canvas.Canvas(response)
#     p.setFont("Helvetica-Bold", 14)
#     p.drawString(200, 800, "Service Report")
#
#     p.setFont("Helvetica", 10)
#     y = 780  # Initial y position
#
#     headers = ["Sl No", "Date", "ServicePlan", "Duration", "Amount", "Username", "Contact", "Paid Amount", "Status"]
#     x_positions = [50, 100, 180, 260, 320, 390, 460, 520, 580]
#
#     # Print headers
#     for i, header in enumerate(headers):
#         p.drawString(x_positions[i], y, header)
#
#     y -= 20
#
#     data = Payment.objects.all()  # Adjust based on your model
#     for index, record in enumerate(data):
#         print(record.SERVICEPLAN.amount)
#         p.drawString(x_positions[0], y, str(index + 1))
#         p.drawString(x_positions[1], y, str(record.date))
#         p.drawString(x_positions[2], y, record.SERVICEPLAN.Splan)
#         p.drawString(x_positions[3], y, str(record.SERVICEPLAN.duration))
#         p.drawString(x_positions[4], y, str(record.SERVICEPLAN.amount))
#         p.drawString(x_positions[5], y, record.USER.name)
#         p.drawString(x_positions[6], y, record.USER.phoneno)
#         p.drawString(x_positions[7], y, str(record.amount))
#         p.drawString(x_positions[8], y, record.status)
#
#         y -= 20  # Move to the next line
#
#     p.showPage()
#     p.save()
#     return response
from django.http import HttpResponse
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from .models import Payment


# def download_report(request):
#     response = HttpResponse(content_type='application/pdf')
#     response['Content-Disposition'] = 'attachment; filename="payment_report.pdf"'
#
#     # Create the PDF document
#     pdf = SimpleDocTemplate(response, pagesize=landscape(letter))
#     elements = []
#
#     # Define table headers
#     headers = ["#", "Date", "Service Plan", "Duration", "Amount", "Username", "Contact", "Paid Amount", "Status"]
#
#     # Fetching data
#     data = Payment.objects.all()
#
#     if not data.exists():
#         return HttpResponse("No records found.")
#
#     table_data = [headers]  # Initialize table data with headers
#
#     # Populate table rows
#     for index, record in enumerate(data, start=1):
#         try:
#             service_plan = record.SERVICEPLAN
#             user = record.USER
#
#             if not service_plan or not user:
#                 print(f"Skipping record {index} due to missing related data")
#                 continue  # Skip records with missing relationships
#
#             row = [
#                 index,
#                 record.date.strftime("%Y-%m-%d"),  # Format date
#                 service_plan.Splan,
#                 service_plan.duration,
#                 service_plan.amount,
#                 user.name,
#                 user.phoneno,
#                 record.amount,
#                 record.status
#             ]
#             table_data.append(row)
#
#         except Exception as e:
#             print(f"Error processing record {index}: {e}")
#             continue  # Skip problematic records
#
#     # Create table
#     table = Table(table_data, colWidths=[30, 80, 100, 60, 60, 100, 80, 80, 80])
#
#     # Add table styling
#     table.setStyle(TableStyle([
#         ('BACKGROUND', (0, 0), (-1, 0), colors.grey),  # Header background
#         ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),  # Header text color
#         ('ALIGN', (0, 0), (-1, -1), 'CENTER'),  # Center alignment
#         ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),  # Header bold
#         ('FONTSIZE', (0, 0), (-1, -1), 10),  # Font size
#         ('BOTTOMPADDING', (0, 0), (-1, 0), 8),  # Padding for headers
#         ('BACKGROUND', (0, 1), (-1, -1), colors.beige),  # Background for data
#         ('GRID', (0, 0), (-1, -1), 1, colors.black)  # Grid lines
#     ]))
#
#     elements.append(table)
#
#     # Build PDF
#     pdf.build(elements)
#     return response
#

# from django.http import HttpResponse
# from reportlab.lib.pagesizes import letter, landscape
# from reportlab.lib import colors
# from reportlab.platypus import (
#     SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, HRFlowable, Image
# )
# from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
# from reportlab.graphics.shapes import Drawing
# from reportlab.graphics.charts.barcharts import VerticalBarChart
# from reportlab.graphics.charts.legends import Legend
# from reportlab.graphics.charts.textlabels import Label
# from reportlab.graphics import renderPDF
# from reportlab.lib.units import inch
# from collections import defaultdict
# import datetime
# from myapp.models import Payment, User, Trainer
#
# def download_report(request):
#     response = HttpResponse(content_type='application/pdf')
#     response['Content-Disposition'] = 'attachment; filename="payment_report.pdf"'
#
#     # Create PDF document with margins
#     pdf = SimpleDocTemplate(response, pagesize=landscape(letter),
#                             leftMargin=40, rightMargin=40, topMargin=50, bottomMargin=30)
#
#     elements = []
#     styles = getSampleStyleSheet()
#
#     # ✅ Define Custom Styles
#     header_style = ParagraphStyle('HeaderStyle', parent=styles['Title'], fontSize=18, alignment=1, spaceAfter=5)
#     subheader_style = ParagraphStyle('SubHeaderStyle', parent=styles['Normal'], fontSize=12, alignment=1, spaceAfter=5)
#     contact_style = ParagraphStyle('ContactStyle', parent=styles['Normal'], fontSize=12, alignment=1, spaceAfter=10)
#
#     # ✅ Fetch statistics
#     total_users = User.objects.count()
#     approved_trainers = Trainer.objects.filter(status="approved").count()
#
#     # ✅ Add Gym Header
#     elements.append(Spacer(1, 20))
#     elements.append(Paragraph("THE BELLY GYM", header_style))
#     elements.append(Paragraph("An Agile Initiative", subheader_style))
#     elements.append(Paragraph("+91 8590198344", contact_style))
#     elements.append(HRFlowable(width="100%", thickness=1, color=colors.black, spaceBefore=10, spaceAfter=10))
#
#     # ✅ Add Summary (User & Trainer Counts)
#     elements.append(Paragraph(f"Total Users: <b>{total_users}</b>", subheader_style))
#     elements.append(Paragraph(f"Approved Trainers: <b>{approved_trainers}</b>", subheader_style))
#     elements.append(Spacer(1, 10))
#
#     # ✅ Fetch daily payment data
#     payments = Payment.objects.all()
#     if not payments.exists():
#         return HttpResponse("No records found.")
#
#     daily_totals = defaultdict(float)
#     for payment in payments:
#         date_str = payment.date.strftime("%Y-%m-%d")  # Format date
#         daily_totals[date_str] += float(payment.amount)  # Ensure numeric type
#     # Sum amounts per date
#
#     # Sort data by date
#     sorted_dates = sorted(daily_totals.keys())
#     sorted_amounts = [daily_totals[date] for date in sorted_dates]
#
#     # ✅ Generate Bar Chart for Daily Payments
#     drawing = Drawing(400, 200)
#     bar_chart = VerticalBarChart()
#     bar_chart.x = 50
#     bar_chart.y = 30
#     bar_chart.height = 150
#     bar_chart.width = 300
#     bar_chart.data = [sorted_amounts]
#     bar_chart.categoryAxis.categoryNames = sorted_dates
#     bar_chart.categoryAxis.labels.boxAnchor = 'ne'
#     bar_chart.valueAxis.valueMin = 0
#     bar_chart.valueAxis.valueMax = max(sorted_amounts) * 1.2  # Scale max value
#     bar_chart.bars[0].fillColor = colors.lightblue # Bar color
#
#     # ✅ Add Labels to Chart
#     title = Label()
#     title.x = 200
#     title.y = 180
#     title.text = "Daily Payment Summary"
#     title.fontSize = 14
#     drawing.add(title)
#
#     drawing.add(bar_chart)
#     elements.append(drawing)
#     elements.append(Spacer(1, 20))
#
#     # ✅ Define table headers
#     headers = ["#", "Date", "Service Plan", "Duration", "Amount", "Username", "Contact", "Paid Amount", "Status"]
#
#     table_data = [headers]  # Initialize table with headers
#
#     # ✅ Populate table rows
#     for index, record in enumerate(payments, start=1):
#         try:
#             service_plan = record.SERVICEPLAN
#             user = record.USER
#
#             if not service_plan or not user:
#                 continue  # Skip records with missing relationships
#
#             row = [
#                 index,
#                 record.date.strftime("%Y-%m-%d"),
#                 service_plan.Splan,
#                 service_plan.duration,
#                 service_plan.amount,
#                 user.name,
#                 user.phoneno,
#                 record.amount,
#                 record.status
#             ]
#             table_data.append(row)
#
#         except Exception as e:
#             print(f"Error processing record {index}: {e}")
#             continue
#
#     # ✅ Create Table
#     table = Table(table_data, colWidths=[30, 80, 100, 60, 60, 100, 80, 80, 80])
#
#     # ✅ Apply Table Styling
#     table.setStyle(TableStyle([
#         ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
#         ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
#         ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
#         ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
#         ('FONTSIZE', (0, 0), (-1, -1), 10),
#         ('BOTTOMPADDING', (0, 0), (-1, 0), 8),
#         ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
#         ('GRID', (0, 0), (-1, -1), 1, colors.black)
#     ]))
#
#     elements.append(table)
#
#     # ✅ Build PDF
#     pdf.build(elements)
#     return response
# from django.http import HttpResponse
# from reportlab.lib.pagesizes import letter, landscape
# from reportlab.lib import colors
# from reportlab.platypus import (
#     SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, HRFlowable
# )
# from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
# from reportlab.graphics.shapes import Drawing
# from reportlab.graphics.charts.barcharts import VerticalBarChart
# from reportlab.graphics.charts.textlabels import Label
# from collections import defaultdict
# from myapp.models import Payment, User, Trainer
#
# def download_report(request):
#     response = HttpResponse(content_type='application/pdf')
#     response['Content-Disposition'] = 'attachment; filename="payment_report.pdf"'
#
#     # ✅ Create PDF Document
#     pdf = SimpleDocTemplate(response, pagesize=landscape(letter),
#                             leftMargin=40, rightMargin=40, topMargin=50, bottomMargin=30)
#     elements = []
#     styles = getSampleStyleSheet()
#
#     # ✅ Define Custom Styles
#     header_style = ParagraphStyle(
#         'HeaderStyle', parent=styles['Title'], fontSize=20, alignment=1, spaceAfter=8, textColor=colors.darkblue
#     )
#     subheader_style = ParagraphStyle(
#         'SubHeaderStyle', parent=styles['Normal'], fontSize=14, alignment=1, spaceAfter=5, textColor=colors.darkred
#     )
#     contact_style = ParagraphStyle(
#         'ContactStyle', parent=styles['Normal'], fontSize=12, alignment=1, spaceAfter=10, textColor=colors.black
#     )
#
#     # ✅ Fetch statistics
#     total_users = User.objects.count()
#     approved_trainers = Trainer.objects.filter(status="approved").count()
#
#     # ✅ Add Gym Header
#     elements.append(Spacer(1, 20))
#     elements.append(Paragraph("THE BELLY GYM", header_style))
#     elements.append(Paragraph("An Agile Initiative", subheader_style))
#     elements.append(Paragraph("+91 8590198344", contact_style))
#     elements.append(HRFlowable(width="100%", thickness=1, color=colors.black, spaceBefore=10, spaceAfter=10))
#
#     # ✅ Summary Section
#     elements.append(Paragraph(f"Total Users: <b>{total_users}</b>", subheader_style))
#     elements.append(Paragraph(f"Approved Trainers: <b>{approved_trainers}</b>", subheader_style))
#     elements.append(Spacer(1, 10))
#
#     # ✅ Fetch daily payment data
#     payments = Payment.objects.all()
#     if not payments.exists():
#         return HttpResponse("No records found.")
#
#     daily_totals = defaultdict(float)
#     for payment in payments:
#         date_str = payment.date.strftime("%Y-%m-%d")
#         daily_totals[date_str] += float(payment.amount)
#
#     # Sort data by date
#     sorted_dates = sorted(daily_totals.keys())
#     sorted_amounts = [daily_totals[date] for date in sorted_dates]
#
#     # ✅ Generate Bar Chart for Daily Payments
#     drawing = Drawing(450, 250)
#
#     bar_chart = VerticalBarChart()
#     bar_chart.x = 50
#     bar_chart.y = 50
#     bar_chart.height = 150
#     bar_chart.width = 350
#     bar_chart.data = [sorted_amounts]
#     bar_chart.categoryAxis.categoryNames = sorted_dates
#     bar_chart.categoryAxis.labels.boxAnchor = 'ne'
#     bar_chart.valueAxis.valueMin = 0
#     bar_chart.valueAxis.valueMax = max(sorted_amounts) * 1.2
#     bar_chart.bars[0].fillColor = colors.lightblue
#
#     # ✅ Add Chart Title
#     chart_title = Label()
#     chart_title.x = 225
#     chart_title.y = 220
#     chart_title.text = "📊 Daily Payment Status"
#     chart_title.fontSize = 16
#     chart_title.fontName = "Helvetica-Bold"
#     chart_title.fillColor = colors.darkblue
#
#     drawing.add(chart_title)
#     drawing.add(bar_chart)
#     elements.append(drawing)
#     elements.append(Spacer(1, 20))
#
#     # ✅ Define table headers
#     headers = ["#", "Date", "Service Plan", "Duration", "Amount", "Username", "Contact", "Paid Amount", "Status"]
#
#     table_data = [headers]
#
#     # ✅ Populate table rows
#     for index, record in enumerate(payments, start=1):
#         try:
#             service_plan = record.SERVICEPLAN
#             user = record.USER
#
#             if not service_plan or not user:
#                 continue
#
#             row = [
#                 index,
#                 record.date.strftime("%Y-%m-%d"),
#                 service_plan.Splan,
#                 service_plan.duration,
#                 service_plan.amount,
#                 user.name,
#                 user.phoneno,
#                 record.amount,
#                 record.status
#             ]
#             table_data.append(row)
#
#         except Exception as e:
#             print(f"Error processing record {index}: {e}")
#             continue
#
#     # ✅ Create Table
#     table = Table(table_data, colWidths=[30, 80, 100, 60, 60, 100, 80, 80, 80])
#
#     # ✅ Apply Improved Table Styling
#     table.setStyle(TableStyle([
#         ('BACKGROUND', (0, 0), (-1, 0), colors.darkblue),
#         ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
#         ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
#         ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
#         ('FONTSIZE', (0, 0), (-1, -1), 11),
#         ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
#         ('BACKGROUND', (0, 1), (-1, -1), colors.lightgrey),
#         ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.beige, colors.whitesmoke]),
#         ('GRID', (0, 0), (-1, -1), 1, colors.black)
#     ]))
#
#     elements.append(table)
#
#     # ✅ Build PDF
#     pdf.build(elements)
#     return response
#
# from django.http import HttpResponse
# from reportlab.lib.pagesizes import letter, landscape
# from reportlab.lib import colors
# from reportlab.platypus import (
#     SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, HRFlowable
# )
# from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
# from reportlab.graphics.shapes import Drawing
# from reportlab.graphics.charts.barcharts import VerticalBarChart
# from reportlab.graphics.charts.textlabels import Label
# from collections import defaultdict
# from myapp.models import Payment, User, Trainer
#
# def download_report(request):
#     response = HttpResponse(content_type='application/pdf')
#     response['Content-Disposition'] = 'attachment; filename="payment_report.pdf"'
#
#     pdf = SimpleDocTemplate(response, pagesize=landscape(letter),
#                             leftMargin=40, rightMargin=40, topMargin=50, bottomMargin=30)
#     elements = []
#     styles = getSampleStyleSheet()
#
#     header_style = ParagraphStyle('HeaderStyle', parent=styles['Title'], fontSize=20, alignment=1, spaceAfter=8, textColor=colors.darkblue)
#     subheader_style = ParagraphStyle('SubHeaderStyle', parent=styles['Normal'], fontSize=14, alignment=1, spaceAfter=5, textColor=colors.darkred)
#     contact_style = ParagraphStyle('ContactStyle', parent=styles['Normal'], fontSize=12, alignment=1, spaceAfter=10, textColor=colors.black)
#
#     total_users = User.objects.count()
#     approved_trainers = Trainer.objects.filter(status="approved").count()
#
#     elements.append(Spacer(1, 20))
#     elements.append(Paragraph("THE BELLY GYM", header_style))
#     elements.append(Paragraph("An Agile Initiative", subheader_style))
#     elements.append(Paragraph("+91 8590198344", contact_style))
#     elements.append(HRFlowable(width="100%", thickness=1, color=colors.black, spaceBefore=10, spaceAfter=10))
#
#     elements.append(Paragraph(f"Total Users: <b>{total_users}</b>", subheader_style))
#     elements.append(Paragraph(f"Approved Trainers: <b>{approved_trainers}</b>", subheader_style))
#     elements.append(Spacer(1, 10))
#
#     payments = Payment.objects.all()
#     if not payments.exists():
#         return HttpResponse("No records found.")
#
#     daily_totals = defaultdict(float)
#     for payment in payments:
#         date_str = payment.date.strftime("%Y-%m-%d")
#         daily_totals[date_str] += float(payment.amount)
#
#     sorted_dates = sorted(daily_totals.keys())
#     sorted_amounts = [daily_totals[date] for date in sorted_dates]
#
#     drawing = Drawing(450, 250)
#     bar_chart = VerticalBarChart()
#     bar_chart.x = 50
#     bar_chart.y = 50
#     bar_chart.height = 150
#     bar_chart.width = 350
#     bar_chart.data = [sorted_amounts]
#     bar_chart.categoryAxis.categoryNames = sorted_dates
#     bar_chart.categoryAxis.labels.boxAnchor = 'ne'
#     bar_chart.valueAxis.valueMin = 0
#     bar_chart.valueAxis.valueMax = max(sorted_amounts) * 1.2
#     bar_chart.bars[0].fillColor = colors.lightblue
#
#     chart_title = Label()
#     chart_title.x = 225
#     chart_title.y = 220
#     chart_title.text = "DailyPaymentStatus"
#     chart_title.fontSize = 16
#     chart_title.fontName = "Helvetica-Bold"
#     chart_title.fillColor = colors.darkblue
#
#     drawing.add(chart_title)
#     drawing.add(bar_chart)
#     elements.append(drawing)
#     elements.append(Spacer(1, 20))
#
#     headers = ["#", "Date", "Service Plan", "Duration", "Amount", "Username", "Contact", "Paid Amount", "Status"]
#     table_data = [headers]
#
#     for index, record in enumerate(payments, start=1):
#         try:
#             service_plan = record.SERVICEPLAN
#             user = record.USER
#             if not service_plan or not user:
#                 continue
#
#             row = [
#                 index,
#                 record.date.strftime("%Y-%m-%d"),
#                 service_plan.Splan,
#                 service_plan.duration,
#                 service_plan.amount,
#                 user.name,
#                 user.phoneno,
#                 record.amount,
#                 record.status
#             ]
#             table_data.append(row)
#         except Exception as e:
#             continue
#
#     table = Table(table_data, colWidths=[30, 80, 100, 60, 60, 100, 80, 80, 80])
#     table.setStyle(TableStyle([
#         ('BACKGROUND', (0, 0), (-1, 0), colors.darkblue),
#         ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
#         ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
#         ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
#         ('FONTSIZE', (0, 0), (-1, -1), 11),
#         ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
#         ('BACKGROUND', (0, 1), (-1, -1), colors.lightgrey),
#         ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.beige, colors.whitesmoke]),
#         ('GRID', (0, 0), (-1, -1), 1, colors.black)
#     ]))
#
#     elements.append(table)
#     pdf.build(elements)
#     return response

from django.http import HttpResponse
from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.platypus import (
    SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, HRFlowable
)
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.graphics.shapes import Drawing
from reportlab.graphics.charts.barcharts import VerticalBarChart
from reportlab.graphics.charts.textlabels import Label
from collections import defaultdict
from myapp.models import Payment, User, Trainer

def download_report(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="payment_report.pdf"'

    pdf = SimpleDocTemplate(response, pagesize=landscape(letter),
                            leftMargin=40, rightMargin=40, topMargin=50, bottomMargin=30)
    elements = []
    styles = getSampleStyleSheet()

    header_style = ParagraphStyle('HeaderStyle', parent=styles['Title'], fontSize=20, alignment=1, spaceAfter=8, textColor=colors.darkblue)
    subheader_style = ParagraphStyle('SubHeaderStyle', parent=styles['Normal'], fontSize=14, alignment=1, spaceAfter=5, textColor=colors.darkred)
    contact_style = ParagraphStyle('ContactStyle', parent=styles['Normal'], fontSize=12, alignment=1, spaceAfter=10, textColor=colors.black)

    total_users = User.objects.count()
    approved_trainers = Trainer.objects.filter(status="approved").count()

    elements.append(Spacer(1, 20))
    elements.append(Paragraph("THE BELLY GYM", header_style))
    elements.append(Paragraph("An Agile Initiative", subheader_style))
    elements.append(Paragraph("+91 8590198344", contact_style))
    elements.append(HRFlowable(width="100%", thickness=1, color=colors.black, spaceBefore=10, spaceAfter=10))

    elements.append(Paragraph(f"Total Users: <b>{total_users}</b>", subheader_style))
    elements.append(Paragraph(f"Approved Trainers: <b>{approved_trainers}</b>", subheader_style))
    elements.append(Spacer(1, 10))

    payments = Payment.objects.all()
    if not payments.exists():
        return HttpResponse("No records found.")

    daily_totals = defaultdict(float)
    for payment in payments:
        date_str = payment.date.strftime("%Y-%m-%d")
        daily_totals[date_str] += float(payment.amount)

    sorted_dates = sorted(daily_totals.keys())
    sorted_amounts = [daily_totals[date] for date in sorted_dates]

    drawing = Drawing(450, 250)
    bar_chart = VerticalBarChart()
    bar_chart.x = 50
    bar_chart.y = 50
    bar_chart.height = 150
    bar_chart.width = 350
    bar_chart.data = [sorted_amounts]
    bar_chart.categoryAxis.categoryNames = sorted_dates
    bar_chart.categoryAxis.labels.boxAnchor = 'ne'
    bar_chart.valueAxis.valueMin = 0
    bar_chart.valueAxis.valueMax = max(sorted_amounts) * 1.2
    bar_chart.bars[0].fillColor = colors.lightblue

    chart_title = Label()
    chart_title.x = 225
    chart_title.y = 220
    chart_title.text = "Daily Payment Status"
    chart_title.fontSize = 16
    chart_title.fontName = "Helvetica-Bold"
    chart_title.fillColor = colors.darkblue

    drawing.add(chart_title)
    drawing.add(bar_chart)
    elements.append(drawing)
    elements.append(Spacer(1, 20))

    headers = ["#", "Date", "Service Plan", "Duration", "Amount", "Username", "Contact", "Paid Amount", "Status"]
    table_data = [headers]

    for index, record in enumerate(payments, start=1):
        try:
            service_plan = record.SERVICEPLAN
            user = record.USER
            if not service_plan or not user:
                continue

            row = [
                index,
                record.date.strftime("%Y-%m-%d"),
                service_plan.Splan,
                service_plan.duration,
                service_plan.amount,
                user.name,
                user.phoneno,
                record.amount,
                record.status
            ]
            table_data.append(row)
        except Exception as e:
            continue

    table = Table(table_data, colWidths=[30, 80, 100, 60, 60, 100, 80, 80, 80])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.darkblue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, -1), 11),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
        ('BACKGROUND', (0, 1), (-1, -1), colors.lightgrey),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.beige, colors.whitesmoke]),
        ('GRID', (0, 0), (-1, -1), 1, colors.black)
    ]))

    elements.append(table)
    pdf.build(elements)
    return response

from django.http import HttpResponse
from reportlab.lib.pagesizes import letter, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from myapp.models import Trainer  # adjust if your model is in a different app

def download_trainer_report(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="approved_trainer_report.pdf"'

    pdf = SimpleDocTemplate(response, pagesize=landscape(letter),
                            leftMargin=30, rightMargin=30, topMargin=30, bottomMargin=30)

    elements = []
    styles = getSampleStyleSheet()
    header_style = ParagraphStyle('HeaderStyle', parent=styles['Title'], fontSize=20, alignment=1, spaceAfter=8, textColor=colors.darkblue)
    subheader_style = ParagraphStyle('SubHeaderStyle', parent=styles['Normal'], fontSize=14, alignment=1, spaceAfter=5, textColor=colors.darkred)
    contact_style = ParagraphStyle('ContactStyle', parent=styles['Normal'], fontSize=12, alignment=1, spaceAfter=10, textColor=colors.black)
    title_style = ParagraphStyle(
        name='TitleStyle',
        parent=styles['Title'],
        fontSize=18,
        alignment=1,
        textColor=colors.darkblue
    )
    elements.append(Spacer(1, 20))
    elements.append(Paragraph("THE BELLY GYM", header_style))
    elements.append(Paragraph("An Agile Initiative", subheader_style))
    elements.append(Paragraph("+91 8590198344", contact_style))
    elements.append(HRFlowable(width="100%", thickness=1, color=colors.black, spaceBefore=10, spaceAfter=10))

    elements.append(Paragraph("Approved Trainer Report", title_style))
    elements.append(Spacer(1, 20))

    trainers = Trainer.objects.filter(status="approved")
    if not trainers.exists():
        elements.append(Paragraph("No approved trainers found.", styles["Normal"]))
        pdf.build(elements)
        return response

    # Table headers
    data = [["#", "Name", "Email", "Phone", "Gender", "Experience", "Qualification"]]

    for i, trainer in enumerate(trainers, start=1):
        data.append([
            i,
            trainer.name,
            trainer.email,
            trainer.phoneno,
            trainer.gender,
            trainer.experience,
            trainer.qualification
        ])

    table = Table(data, colWidths=[30, 100, 150, 90, 60, 80, 100])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.darkblue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.beige, colors.white]),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
    ]))

    elements.append(table)
    pdf.build(elements)

    return response
from django.http import HttpResponse
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import inch
from .models import User  # Update if your model has a different name

# def download_user_report(request):
#     # Create the HttpResponse object with PDF headers.
#     response = HttpResponse(content_type='application/pdf')
#     response['Content-Disposition'] = 'attachment; filename="user_report.pdf"'
#
#     # Create the PDF object
#     p = canvas.Canvas(response, pagesize=letter)
#     width, height = letter
#     y = height - inch
#     p.setFont("Helvetica-Bold", 16)
#     p.drawString(inch, y, "Registered User Report")
#     y -= 0.5 * inch
#
#     # Table Headers
#     p.setFont("Helvetica-Bold", 12)
#     p.drawString(inch, y, "No")
#     p.drawString(inch + 40, y, "Name")
#     p.drawString(inch + 200, y, "Phone")
#     p.drawString(inch + 320, y, "Gender")
#     p.drawString(inch + 400, y, "Health")
#
#     y -= 0.3 * inch
#
#     users = User.objects.all()  # Fetch all users, or filter as needed
#
#     p.setFont("Helvetica", 10)
#     for i, user in enumerate(users, start=1):
#         if y < 100:
#             p.showPage()
#             y = height - inch
#             p.setFont("Helvetica", 10)
#
#         p.drawString(inch, y, str(i))
#         p.drawString(inch + 40, y, user.name)
#         p.drawString(inch + 200, y, user.phoneno)
#         p.drawString(inch + 320, y, user.gender)
#         health_info = f"H: {user.height}, W: {user.weight}"
#         p.drawString(inch + 400, y, health_info)
#         y -= 0.25 * inch
#
#     p.showPage()
#     p.save()
#     return response
from django.http import HttpResponse
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from .models import User  # Ensure User model is correctly imported

def download_user_report(request):
    # Create the HttpResponse object with PDF headers.
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="user_report.pdf"'

    # Create the PDF object
    p = canvas.Canvas(response, pagesize=letter)
    width, height = letter
    y = height - inch

    # Centered Gym Details
    center_x = width / 2  # Find the center of the page
    p.setFont("Helvetica-Bold", 20)
    p.drawCentredString(center_x, y, "BELLY GYM")
    y -= 0.3 * inch

    p.setFont("Helvetica-Bold", 14)
    p.drawCentredString(center_x, y, "An Agile Initiative")
    y -= 0.25 * inch

    p.setFont("Helvetica", 12)
    p.drawCentredString(center_x, y, "Contact: +91 8590198344")
    y -= 0.5 * inch

    # p.setFont("Helvetica-Bold", 16)
    # p.drawCentredString(center_x, y, "Registered User Report")
    # y -= 0.5 * inch

    # Table Headers
    p.setFont("Helvetica-Bold", 12)
    p.drawString(inch, y, "No")
    p.drawString(inch + 40, y, "Name")
    p.drawString(inch + 200, y, "Phone")
    p.drawString(inch + 320, y, "Gender")
    p.drawString(inch + 400, y, "Health")

    y -= 0.3 * inch

    users = User.objects.all()  # Fetch all users, or filter as needed

    p.setFont("Helvetica", 10)
    for i, user in enumerate(users, start=1):
        if y < 100:
            p.showPage()
            y = height - inch
            p.setFont("Helvetica", 10)

        p.drawString(inch, y, str(i))
        p.drawString(inch + 40, y, user.name)
        p.drawString(inch + 200, y, user.phoneno)
        p.drawString(inch + 320, y, user.gender)
        health_info = f"H: {user.height}, W: {user.weight}"
        p.drawString(inch + 400, y, health_info)
        y -= 0.25 * inch

    p.showPage()
    p.save()
    return response


from django.http import HttpResponse
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from .models import Progress  # Update with your actual model

def download_user_progress_report(request):
    # Create HTTP response with PDF headers
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="user_progress_report.pdf"'

    # Set up PDF canvas
    p = canvas.Canvas(response, pagesize=A4)
    width, height = A4
    y = height - 50  # Start near top

    # Title
    p.setFont("Helvetica-Bold", 14)
    p.drawString(200, y, "User Progress Report")
    y -= 30

    # Column headers
    p.setFont("Helvetica-Bold", 10)
    headers = ['Sl No', 'Date', 'User Name', 'Email', 'Workout Plan', 'Notes', 'Calories', 'Weight']
    x_positions = [30, 70, 130, 220, 320, 400, 470, 530]
    for x, header in zip(x_positions, headers):
        p.drawString(x, y, header)
    y -= 20

    # Body content
    p.setFont("Helvetica", 9)
    progress_data = Progress.objects.select_related('USER', 'WORKOUTPLAN').all()

    for idx, item in enumerate(progress_data, start=1):
        if y < 50:
            p.showPage()
            y = height - 50
            p.setFont("Helvetica-Bold", 10)
            for x, header in zip(x_positions, headers):
                p.drawString(x, y, header)
            y -= 20
            p.setFont("Helvetica", 9)

        row = [
            str(idx),
            str(item.date),
            item.USER.name,
            item.USER.email,
            item.WORKOUTPLAN.workoutname,
            item.progressnotes[:20] + ("..." if len(item.progressnotes) > 20 else ""),
            str(item.caloriesburned),
            str(item.weight)
        ]

        for x, cell in zip(x_positions, row):
            p.drawString(x, y, cell)
        y -= 18

    p.showPage()
    p.save()
    return response


def add_diet_chart(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('logout succesfull');window.location="/myapp/login/"</script>''')

    return render(request,"trainer/Diet_chart.html")

def add_diet_chart_post(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('logout succesfull');window.location="/myapp/login/"</script>''')

    Name=request.POST['textfield']
    Date=request.POST['textfield2']
    Diet_charts=request.FILES['fileField3']
    BMI = request.POST['BMI']
    Alcoholabuse = request.POST['Alcoholabuse']
    Allergies = request.POST['Allergies']
    Arthritis = request.POST['Arthritis']
    Asthma = request.POST['Asthma']
    Bloodpressure = request.POST['Bloodpressure']
    Cancer = request.POST['Cancer']
    Cholestrol = request.POST['Cholestrol']
    Depression = request.POST['Depression']
    Diabetes = request.POST['Diabetes']
    Druguse = request.POST['Druguse']
    Gender = request.POST['Gender']
    Headaches = request.POST['Headaches']
    Heartproblem = request.POST['Heartproblem']
    Kidney = request.POST['Kidney']
    Liver = request.POST['Liver']
    Obicity = request.POST['Obicity']
    Pregnancy = request.POST['Pregnancy']
    Smoking = request.POST['Smoking']
    Stroke = request.POST['Stroke']


    yobj=Diet_chart()
    yobj.Name=Name
    yobj.Date=Date

    fs = FileSystemStorage()
    date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
    fn = fs.save(date, Diet_charts)
    path = fs.url(date)
    yobj.Dietplan=path
    yobj.Time= datetime.datetime.now().strftime("%H:%M:%S")
    yobj.BMI=BMI
    yobj.Alcoholabuse=Alcoholabuse
    yobj.Allergies=Allergies
    yobj.Arthritis=Arthritis
    yobj.Asthma=Asthma
    yobj.Bloodpressure=Bloodpressure
    yobj.Cancer=Cancer
    yobj.Cholestrol=Cholestrol
    yobj.Depression=Depression
    yobj.Diabetes=Diabetes
    yobj.Druguse=Druguse
    yobj.Gender=Gender
    yobj.Headaches=Headaches
    yobj.Heartproblem=Heartproblem
    yobj.Kidney=Kidney
    yobj.Liver=Liver
    yobj.Obicity=Obicity
    yobj.Pregnancy=Pregnancy
    yobj.bmi=BMI
    yobj.Smoking=Smoking
    yobj.Stroke=Stroke
    yobj.save()


    return HttpResponse('''<script>alert('diet add');window.location="/myapp/add_diet_chart/"</script>''')





def View_diet_chart(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('logout succesfull');window.location="/myapp/login/"</script>''')

    k = Diet_chart.objects.all()
    return render(request, "trainer/view_diet_chart.html", {'data': k})



def View_diet_chart_post(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('logout succesfull');window.location="/myapp/login/"</script>''')

    search = request.POST['textfield']
    u = Diet_chart.objects.filter(Name__icontains=search)
    return render(request, "trainer/view_diet_chart.html", {'data': u})


def delete_diet_chart(request,id):
    Diet_chart.objects.filter(id=id).delete()
    return HttpResponse("ok")




def Edit_diet_chart(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('logout succesfull');window.location="/myapp/login/"</script>''')

    oi= Diet_chart.objects.get(id=id)
    return render(request,"trainer/Edit_diet_chart.html",{'data':oi,'id':id})


def Edit_diet_chart_post(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('logout succesfull');window.location="/myapp/login/"</script>''')

    id = request.POST['id']
    Name = request.POST['textfield']
    Date = request.POST['textfield2']

    BMI = request.POST['BMI']
    Alcoholabuse = request.POST['Alcoholabuse']
    Allergies = request.POST['Allergies']
    Arthritis = request.POST['Arthritis']
    Asthma = request.POST['Asthma']
    Bloodpressure = request.POST['Bloodpressure']
    Cancer = request.POST['Cancer']
    Cholestrol = request.POST['Cholestrol']
    Depression = request.POST['Depression']
    Diabetes = request.POST['Diabetes']
    Druguse = request.POST['Druguse']
    Gender = request.POST['Gender']
    Headaches = request.POST['Headaches']
    Heartproblem = request.POST['Heartproblem']
    Kidney = request.POST['Kidney']
    Liver = request.POST['Liver']
    Obicity = request.POST['Obicity']
    Pregnancy = request.POST['Pregnancy']
    Smoking = request.POST['Smoking']
    Stroke = request.POST['Stroke']



    if 'fileField3' in request.FILES:
        Diet_charts = request.FILES['fileField3']


        fs = FileSystemStorage()
        date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
        fn = fs.save(date, Diet_charts)
        path = fs.url(date)
        Diet_chart.objects.filter(id=id).update(Name=Name, Date=Date, Dietplan=path, bmi=BMI, Alcoholabuse=Alcoholabuse,
                                                Allergies=Allergies, Arthritis=Arthritis, Asthma=Asthma, Bloodpressure=Bloodpressure, Cancer=Cancer,
                                                Cholestrol=Cholestrol,Depression=Depression,Diabetes=Diabetes,Druguse=Druguse,Gender=Gender,
                                                Headaches=Headaches,Heartproblem=Heartproblem,Kidney=Kidney,Liver=Liver,Obicity=Obicity,
                                                Pregnancy=Pregnancy,Smoking=Smoking,Stroke=Stroke,

                                                )

    else:

        Diet_chart.objects.filter(id=id).update(Name=Name, Date=Date, bmi=BMI,
                                                Alcoholabuse=Alcoholabuse,
                                                Allergies=Allergies, Arthritis=Arthritis, Asthma=Asthma,
                                                Bloodpressure=Bloodpressure, Cancer=Cancer,
                                                Cholestrol=Cholestrol, Depression=Depression, Diabetes=Diabetes,
                                                Druguse=Druguse, Gender=Gender,
                                                Headaches=Headaches, Heartproblem=Heartproblem, Kidney=Kidney,
                                                Liver=Liver, Obicity=Obicity,
                                                Pregnancy=Pregnancy, Smoking=Smoking, Stroke=Stroke,

                                                )

    return HttpResponse('''<script>alert('Done');window.location='/myapp/View_diet_chart/'</script>''')




def openingpage(requets):
    return render(requets,'openingpage.html')













#
#
# def nutrition_detect(request):
#     photo = request.POST['photo']
#
#     import datetime
#     import base64
#
#     date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
#     a = base64.b64decode(photo)
#     fh = open("C:\\Users\\bibin\\Music\\GYMGUIDE\\GYMGUIDE\\media\\" + date + ".jpg", "wb")
#     fh.write(a)
#     fh.close()
#
#     from myapp.classify import check
#     pred = check("C:\\Users\\bibin\\Music\\GYMGUIDE\\GYMGUIDE\\media\\" + date + ".jpg")
#     return JsonResponse({"status": "ok", "name": str(pred[0])})
#
#
# import requests
#
#
# def get_nutrition(product_name):
#     # Your Nutritionix API credentials
#     app_id = '3a5f3826'  # Replace with your actual app ID
#     app_key = '8e86b2acf72fc581611123a8981527c5-'  # Replace with your actual app key
#
#     # Define the endpoint
#     url = "https://trackapi.nutritionix.com/v2/natural/nutrients"
#
#     # Set the headers with your API credentials
#     headers = {
#         'x-app-id': app_id,
#         'x-app-key': app_key,
#     }
#
#     # Set the data for the API request (product name)
#     data = {
#         'query': product_name,
#     }
#
#     # Send the POST request to the Nutritionix API
#     response = requests.post(url, headers=headers, json=data)
#
#     if response.status_code == 200:
#         nutrition_info = response.json()
#         return nutrition_info
#     else:
#         return f"Error {response.status_code}: {response.text}"
#
#
# # Example usage
# product_name = "beef_carpaccio"
# nutrition = get_nutrition(product_name)
# print(nutrition)
#
# {
#     "foods": [
#         {
#             "food_name": "banana",
#             "serving_qty": 1,
#             "serving_unit": "medium",
#             "nf_calories": 105,
#             "nf_total_fat": 0.3,
#             "nf_saturated_fat": 0.1,
#             "nf_cholesterol": 0,
#             "nf_sodium": 1,
#             "nf_total_carbohydrate": 27,
#             "nf_dietary_fiber": 3,
#             "nf_sugars": 14,
#             "nf_protein": 1.3
#         }
#     ]
# }




import os
import base64
import datetime
import requests
from django.http import JsonResponse
from django.conf import settings
from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
from myapp.classify import check  # Ensure this is the correct import


def nutrition_detect(request):
    # try:
    photo = request.POST['photo']
    date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")

    # Save the image dynamically using Django's MEDIA_ROOT
    file_name = f"{date}.jpg"
    file_path = default_storage.save(file_name, ContentFile(base64.b64decode(photo)))

    # Classify the image
    pred = check(os.path.join(settings.MEDIA_ROOT, file_name))

    # Get nutrition info
    nutrition_data = get_nutrition(pred[0])

    return JsonResponse({"status": "ok", "food": pred[0], "nutrition": nutrition_data})
    # except Exception as e:
    #     return JsonResponse({"status": "error", "message": str(e)})




def get_nutrition(product_name):
    app_id = "3a5f3826"  # Load from environment variables
    app_key = "c15349b699a3bc5d18190ac91c62ef83"

    if not app_id or not app_key:
        return {"error": "Missing API credentials"}

    url = "https://trackapi.nutritionix.com/v2/natural/nutrients"
    headers = {'x-app-id': app_id, 'x-app-key': app_key}
    data = {'query': product_name}

    try:
        response = requests.post(url, headers=headers, json=data)
        response.raise_for_status()
        return format_nutrition_response(response.json())
    except requests.exceptions.RequestException as e:
        return {"error": str(e)}


def format_nutrition_response(nutrition_info):
    if "foods" in nutrition_info:
        food_data = nutrition_info["foods"][0]
        return {
            "food_name": food_data.get("food_name", "Unknown"),
            "calories": food_data.get("nf_calories", 0),
            "protein": food_data.get("nf_protein", 0),
            "fat": food_data.get("nf_total_fat", 0),
            "carbs": food_data.get("nf_total_carbohydrate", 0),
        }
    return {"error": "Invalid response format"}










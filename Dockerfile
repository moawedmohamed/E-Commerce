FROM ubuntu:latest

# تعيين المتغير لمنع رسائل التفاعل أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تحديث الحزم وتثبيت Node.js وNano وأدوات إضافية
RUN apt update && apt install -y \
    curl \
    nano \
    vim \
    sudo && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs && \
    npm install -g npm && \
    apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/bin/bash","-c" ]
# إنشاء مجموعة ومستخدم جديد
RUN groupadd moawed && useradd -m -g moawed moawedmohamed && \
    echo "moawedmohamed ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# تغيير المستخدم إلى المستخدم الجديد
USER moawedmohamed

# تعيين دليل العمل داخل الحاوية
WORKDIR /home/moawedmohamed/app

# التحقق من الإعدادات
RUN node -v && npm -v && nano --version
RUN id
# تشغيل الحاوية في الوضع التفاعلي
CMD ["bash"]

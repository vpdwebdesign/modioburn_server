#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

#include "rbacusermanager.h"

RBACUserManager::RBACUserManager(User *parent)
    : User(parent)
{
    m_role = new Role(this);
    m_session = new Session(this);

    connect(this, &RBACUserManager::authenticated, [=]() {
        QString uname = this->username();
        m_role->setRoleIdFromUsername(uname);
    });

    connect(m_role, &Role::rolePermissionsSet, [=]() {
        m_session->start();
    });

    connect(m_session, &Session::sessionStarted, [=]() {
        QString uname = this->username();
        QString uRole = m_role->role();
        m_session->setUsername(uname);
        m_session->setRole(uRole);
        m_session->setLoggedIn(true);
        m_session->setSwitchedRoles(false);
        m_session->setSelectedRole(QString());
    });

    connect(m_session, &Session::sessionStopped, [=]() {
        this->setName(QString());
        this->setGender(QString());
        this->setPhone(QString());
        this->setEmail(QString());
        this->setUsername(QString());
        this->setPassStr(QString());
        this->setStatus(QString());

        m_role->setRoleID(0);
        m_role->setRole(QString());
        m_role->deletePermissions();

        m_session->setUsername(QString());
        m_session->setRole(QString());
        m_session->setLoggedIn(false);
        m_session->setSwitchedRoles(false);
        m_session->setSelectedRole(QString());
    });
}

Role *RBACUserManager::role() const
{
    return m_role;
}

void RBACUserManager::setRole(Role *role)
{
    if (role != m_role)
    {
        m_role = role;
        emit roleChanged();
    }
}

Session *RBACUserManager::session() const
{
    return m_session;
}

void RBACUserManager::setSession(Session *session)
{
    if (session != m_session)
    {
        m_session = session;
        emit sessionChanged();
    }
}

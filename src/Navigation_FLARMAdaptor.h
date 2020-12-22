/***************************************************************************
 *   Copyright (C) 2019-2020 by Stefan Kebekus                             *
 *   stefan.kebekus@gmail.com                                              *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#pragma once

#include <QTcpSocket>
#include <QTimer>
#include <QObject>

namespace Navigation {

class FLARMAdaptor : public QObject {
    Q_OBJECT

public:
    /*! \brief Default constructor
     *
     * @param parent The standard QObject parent pointer
     */
    explicit FLARMAdaptor(QObject *parent = nullptr);

    // Standard destructor
    ~FLARMAdaptor() override = default;

    Q_PROPERTY(bool receiving READ receiving NOTIFY receivingChanged)
    bool receiving() const;



signals:
    void receivingChanged();

private slots:
    void connectToFLARM();

    void receiveSocketConnected();
    void receiveSocketDisconnected();
    void receiveSocketErrorOccurred(QAbstractSocket::SocketError socketError);

    void readFromStream();

    void readFromSimulatorStream();

    void processFLARMMessage(QString msg);

private:
    QTimer connectTimer;

    QTcpSocket socket;
    QTextStream stream;

    // Simulator related members
    QTextStream simulatorStream;
    QTimer simulatorTimer;
    int lastTime {0};
    QString lastPayload;
};

}